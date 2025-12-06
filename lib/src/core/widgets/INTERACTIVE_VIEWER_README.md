# InteractiveViewer Example - Reusable Widget

A complete, reusable Flutter widget that provides an InteractiveViewer with zoom controls, split screen functionality, and more.

## Features

✅ **Zoom In/Out Controls** - Arrow buttons (+/-) for precise zoom control  
✅ **Split Screen Mode** - Horizontal and vertical split screen views  
✅ **Pan & Zoom Gestures** - Native Flutter InteractiveViewer gestures  
✅ **Reset View** - One-click reset to initial zoom and position  
✅ **Zoom Level Indicator** - Real-time zoom percentage display  
✅ **Fully Customizable** - Configurable min/max zoom, colors, callbacks  

## Quick Start

### Option 1: Use the Widget Directly

```dart
import 'package:kuick_workflow/src/core/widgets/interactive_viewer_example.dart';

InteractiveViewerExample(
  child: YourContentWidget(),
  showControls: true,
  enableSplitScreen: true,
)
```

### Option 2: Copy to Another Project

1. Copy `interactive_viewer_standalone_example.dart` to your project
2. Import and use:

```dart
import 'path/to/interactive_viewer_standalone_example.dart';

InteractiveViewerExample(
  child: YourContentWidget(),
)
```

## Usage Examples

### Basic Usage

```dart
InteractiveViewerExample(
  child: Container(
    width: 2000,
    height: 2000,
    child: YourContent(),
  ),
)
```

### With Custom Settings

```dart
InteractiveViewerExample(
  child: YourContentWidget(),
  showControls: true,
  enableSplitScreen: true,
  minScale: 0.25,
  maxScale: 8.0,
  initialScale: 1.5,
  backgroundColor: Colors.grey[200],
  onZoomChanged: (scale) {
    print('Zoom: ${(scale * 100).toStringAsFixed(0)}%');
  },
)
```

### Without Controls

```dart
InteractiveViewerExample(
  child: YourContentWidget(),
  showControls: false,
  enableSplitScreen: false,
)
```

## Parameters

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `child` | `Widget` | **required** | The widget to display inside the viewer |
| `showControls` | `bool` | `true` | Show zoom control buttons |
| `enableSplitScreen` | `bool` | `true` | Enable split screen functionality |
| `minScale` | `double` | `0.5` | Minimum zoom scale |
| `maxScale` | `double` | `4.0` | Maximum zoom scale |
| `initialScale` | `double` | `1.0` | Initial zoom scale |
| `backgroundColor` | `Color?` | `Colors.grey[100]` | Background color |
| `onZoomChanged` | `ValueChanged<double>?` | `null` | Callback when zoom changes |

## Controls

### Zoom Controls (Top Right)
- **+ Button**: Zoom in (20% per click)
- **- Button**: Zoom out (20% per click)
- **Reset Button**: Reset to initial zoom and position

### Split Screen Controls
- **Split Screen Toggle**: Enable/disable split screen
- **Horizontal Split**: Split screen horizontally
- **Vertical Split**: Split screen vertically

### Zoom Indicator
- Shows current zoom level as percentage (e.g., "150%")

## Gestures

The widget supports all standard InteractiveViewer gestures:
- **Pinch to Zoom**: Two-finger pinch gesture
- **Pan**: Drag to move around
- **Double Tap**: Zoom in/out (native InteractiveViewer behavior)

## Example Demo Page

See `interactive_viewer_demo.dart` for a complete example with:
- Demo content (grid of boxes)
- Feature list
- All controls enabled

## Integration in Routes

The demo page is already integrated in the routes:

```dart
KuickBase(
  KuickRoutes.interactiveViewer, 
  screen: const InteractiveViewerDemo(), 
  requireAuth: true
)
```

Access it via: `/interactive-viewer`

## Use Cases

- **Canvas/Diagram Editors**: Zoom and pan large diagrams
- **Image Viewers**: View high-resolution images
- **Maps**: Interactive map viewing
- **Design Tools**: UI/UX design canvases
- **Data Visualization**: Large charts and graphs
- **Document Viewers**: PDF or document viewing

## Tips

1. **Large Content**: Set explicit width/height on your child widget for best results
2. **Performance**: For very large content, consider using `RepaintBoundary`
3. **Customization**: Override colors and styles to match your app theme
4. **Callbacks**: Use `onZoomChanged` to sync with other UI elements

## Troubleshooting

**Issue**: Content doesn't zoom properly  
**Solution**: Ensure your child widget has explicit dimensions

**Issue**: Controls not visible  
**Solution**: Check that `showControls: true` and there's enough space

**Issue**: Split screen not working  
**Solution**: Ensure `enableSplitScreen: true`

## License

This widget is part of the kuick_workflow project and can be freely used in other projects.






