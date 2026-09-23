import AppKit
import AVFoundation
struct Shot {
 let name:String; let world:WorldStyle; let camera:CameraPresentation; let season:Season; let time:Double
}
@main struct Capture {
 static func main() throws {
  let base=URL(fileURLWithPath:CommandLine.arguments[2]);try FileManager.default.createDirectory(at:base,withIntermediateDirectories:true)
  let samples=CommandLine.arguments[1]=="samples"
  var shots:[Shot]=[]
  if samples {
   for camera:CameraPresentation in [.cinematic,.chase,.wide,.side] { for t in [12.0,40,80,140] { shots.append(Shot(name:"forest-\(camera.rawValue)-\(Int(t))",world:.expanded,camera:camera,season:.summer,time:t)) } }
   for camera:CameraPresentation in [.chase,.overhead] { for t in [12.0,40,80] {shots.append(Shot(name:"city2-\(camera.rawValue)-\(Int(t))",world:.city2,camera:camera,season:.summer,time:t))} }
  } else {
   let spec=CommandLine.arguments[3].split(separator:",").map(String.init)
   shots=[Shot(name:spec[0],world:WorldStyle(rawValue:spec[1])!,camera:CameraPresentation(rawValue:spec[2])!,season:Season(rawValue:spec[3])!,time:Double(spec[4])!)]
  }
  for shot in shots { try autoreleasepool {
   let renderer=try BirdRenderer(seed:819274,worldStyle:shot.world,flock:FlockConfiguration(count:shot.world == .classic ? 2:3,formation:shot.world == .classic ? .loose:.triangle,palette:shot.world == .classic ? .monochrome:.mixed),cameraPresentation:shot.camera,forestDensity:shot.world == .classic ? 1:0.85,cityFlight:.rooftops,season:shot.season,trailsEnabled:shot.world != .classic)
   for _ in 0..<Int(shot.time*60) {renderer.simulation.advance(by:1/60.0)}
   let temp=base.appendingPathComponent("scratch.png")
   for _ in 0..<4 {try renderer.snapshot(to:temp,width:samples ? 640:1280,height:samples ? 360:720);renderer.settleMediaGeometry()}
   if samples {try FileManager.default.copyItem(at:temp,to:base.appendingPathComponent(shot.name+".png"))}
   else {
    let dir=base.appendingPathComponent(shot.name);try FileManager.default.createDirectory(at:dir,withIntermediateDirectories:true)
    for frame in 0..<90 {try autoreleasepool { renderer.simulation.advance(by:1/30.0);try renderer.snapshot(to:dir.appendingPathComponent(String(format:"%03d.png",frame)),width:1280,height:720);renderer.settleMediaGeometry() }}
    try encode(dir:dir,to:base.appendingPathComponent(shot.name+".mp4"))
    let rep=NSBitmapImageRep(data:try Data(contentsOf:dir.appendingPathComponent("000.png")))!
    try rep.representation(using:.jpeg,properties:[.compressionFactor:0.88])!.write(to:base.appendingPathComponent(shot.name+".jpg"))
   }
   print("Captured \(shot.name)");fflush(stdout)
  }}
 }
 static func encode(dir:URL,to url:URL) throws {
  let writer=try AVAssetWriter(outputURL:url,fileType:.mp4)
  writer.shouldOptimizeForNetworkUse=true
  let input=AVAssetWriterInput(mediaType:.video,outputSettings:[AVVideoCodecKey:AVVideoCodecType.h264,AVVideoWidthKey:1280,AVVideoHeightKey:720,AVVideoCompressionPropertiesKey:[AVVideoAverageBitRateKey:2800000,AVVideoMaxKeyFrameIntervalKey:30,AVVideoProfileLevelKey:AVVideoProfileLevelH264HighAutoLevel]])
  let adaptor=AVAssetWriterInputPixelBufferAdaptor(assetWriterInput:input,sourcePixelBufferAttributes:[kCVPixelBufferPixelFormatTypeKey as String:kCVPixelFormatType_32ARGB,kCVPixelBufferWidthKey as String:1280,kCVPixelBufferHeightKey as String:720,kCVPixelBufferCGImageCompatibilityKey as String:true,kCVPixelBufferCGBitmapContextCompatibilityKey as String:true])
  writer.add(input);writer.startWriting();writer.startSession(atSourceTime:.zero)
  for n in 0..<90 {
   while !input.isReadyForMoreMediaData {Thread.sleep(forTimeInterval:0.005)}
   try autoreleasepool {
    let img=NSBitmapImageRep(data:try Data(contentsOf:dir.appendingPathComponent(String(format:"%03d.png",n))))!.cgImage!
    var pb:CVPixelBuffer?; CVPixelBufferPoolCreatePixelBuffer(nil,adaptor.pixelBufferPool!,&pb)
    let buffer=pb!;CVPixelBufferLockBaseAddress(buffer,[])
    let ctx=CGContext(data:CVPixelBufferGetBaseAddress(buffer),width:1280,height:720,bitsPerComponent:8,bytesPerRow:CVPixelBufferGetBytesPerRow(buffer),space:CGColorSpaceCreateDeviceRGB(),bitmapInfo:CGImageAlphaInfo.noneSkipFirst.rawValue)!
    ctx.draw(img,in:CGRect(x:0,y:0,width:1280,height:720));CVPixelBufferUnlockBaseAddress(buffer,[])
    guard adaptor.append(buffer,withPresentationTime:CMTime(value:Int64(n),timescale:30)) else {throw writer.error!}
   }
  }
  input.markAsFinished();let done=DispatchSemaphore(value:0);writer.finishWriting{done.signal()};done.wait()
  if let error=writer.error {throw error}
 }
}
