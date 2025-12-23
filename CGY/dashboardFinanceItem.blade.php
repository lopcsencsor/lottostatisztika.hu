<div class="col-lg-3 col-6">
    <!-- small box -->
    <div class="{{ $box }}">
        <div class="inner">
            <h3>{{ $label }}-{{ $function }} {{ $endlabel }}</h3>
            <p>{{ $title }}</p>
        </div>
        <div class="icon">
            <i class="{{ $icon }}"></i>
        </div>
        <a href="{{ route($route) }}" class="small-box-footer">{{ $title }} <i class="fas fa-arrow-circle-right"></i></a>
    </div>
</div>
