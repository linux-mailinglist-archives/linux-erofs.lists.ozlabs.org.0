Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4B7D561740
	for <lists+linux-erofs@lfdr.de>; Thu, 30 Jun 2022 12:07:03 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4LYYsD08CFz3cd2
	for <lists+linux-erofs@lfdr.de>; Thu, 30 Jun 2022 20:06:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=JyRaAuOR;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2607:f8b0:4864:20::22b; helo=mail-oi1-x22b.google.com; envelope-from=sjg@google.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=JyRaAuOR;
	dkim-atps=neutral
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4LYYs50vwSz3bm8
	for <linux-erofs@lists.ozlabs.org>; Thu, 30 Jun 2022 20:06:47 +1000 (AEST)
Received: by mail-oi1-x22b.google.com with SMTP id i3so1046108oif.13
        for <linux-erofs@lists.ozlabs.org>; Thu, 30 Jun 2022 03:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MkXUcE+SH8JfFpz08xbJfhHc/D7QFv5vAzdLbXGElck=;
        b=JyRaAuOR5P7b3c+dMsQoZD/LLR48yTgS+jlPzsF5hhz+M9j9HYqZULiGdWrA0ZXHuX
         xUb9RYTotjWMMfM4XOZvw9Na6HP0PgeZZm6w311PEmqeKx/u72Ah53UqYUFh9VpM0nM1
         ihozAbAfBpwQ/hcZZPjZ6RV+v8hVEhnyD7spQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MkXUcE+SH8JfFpz08xbJfhHc/D7QFv5vAzdLbXGElck=;
        b=nKVCPdJzryOLc9V6EIcBqJC6r/RNEw7kdTuDTE0sMBbuED1N75S3OZapQI3g5TIwWa
         eXXCu6xJbBG+2Lct1biIgRD+Jy5WvgiEHVkou9oyURxB20otlSKkcfE2TUD/59wxzO6+
         U7/Qi8c+znjjQMEUM0nQ0Ysu8nciZbuFzY+VQvMwT5VC9Z2gHcAXwSE2BV5UNolck//y
         jam3CtK/ztCNH5lxzS3ZBUngXL689d6qUnMoKJK+bVNkURS4YuPdGGGPXVf626YpJ+6e
         HwzIqGn4DSRsYRtaDQPFqdrRdJLZ3LJJsX215crNO9JYp7DKpF4qKa0L5pJ+MoeiPbBI
         rx2A==
X-Gm-Message-State: AJIora9pjP9IGrXH1hVeYVfAjX81gcer5Rj820ZQdZDIjYwuldYsCXzv
	LWaresLNfHKnddVd1ooBHJwnInLD7eweuHVhN64VGg==
X-Google-Smtp-Source: AGRyM1sCsKyVX/+cKZDzLLoaSV3uTCPPX7odjgNYeJL/yuQbFiIeFA+dETd2CJPNRf+eBgaoZI/kSsZz2zdjdB8XZMA=
X-Received: by 2002:a05:6808:f8b:b0:335:cc46:6575 with SMTP id
 o11-20020a0568080f8b00b00335cc466575mr603723oiw.64.1656583601329; Thu, 30 Jun
 2022 03:06:41 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1656401086.git.wqu@suse.com> <9f4b43b84a688b0367a87da2d4e0eb303a36bf32.1656401086.git.wqu@suse.com>
In-Reply-To: <9f4b43b84a688b0367a87da2d4e0eb303a36bf32.1656401086.git.wqu@suse.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 30 Jun 2022 04:06:23 -0600
Message-ID: <CAPnjgZ1yNXwQ44HBwe147hrC1mYsU4Lnyz-WVDHR_anwqYLBSg@mail.gmail.com>
Subject: Re: [PATCH RFC 6/8] fs: sandboxfs: add sandbox_fs_get_blocksize()
To: Qu Wenruo <wqu@suse.com>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: linux-erofs@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linux-erofs/>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Help: <mailto:linux-erofs-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=subscribe>
Cc: Tom Rini <trini@konsulko.com>, jnhuang95@gmail.com, Joao Marcos Costa <joaomarcos.costa@bootlin.com>, =?UTF-8?B?TWFyZWsgQmVow7pu?= <marek.behun@nic.cz>, U-Boot Mailing List <u-boot@lists.denx.de>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Miquel Raynal <miquel.raynal@bootlin.com>, linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Tue, 28 Jun 2022 at 01:28, Qu Wenruo <wqu@suse.com> wrote:
>
> This is to make sandboxfs to report blocksize it supports for
> _fs_read() to handle unaligned read.
>
> Unlike all other fses, sandboxfs can handle unaligned read/write without
> any problem since it's calling read()/write(), which doesn't bother the
> blocksize at all.
>
> This change is mostly to make testing of _fs_read() much easier.
>
> Cc: Simon Glass <sjg@chromium.org>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  arch/sandbox/cpu/os.c  | 11 +++++++++++
>  fs/fs.c                |  2 +-
>  fs/sandbox/sandboxfs.c | 14 ++++++++++++++
>  include/os.h           |  8 ++++++++
>  include/sandboxfs.h    |  1 +
>  5 files changed, 35 insertions(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

with a comment as requested below

>
> diff --git a/arch/sandbox/cpu/os.c b/arch/sandbox/cpu/os.c
> index 5ea54179176c..6c29f29bdd9b 100644
> --- a/arch/sandbox/cpu/os.c
> +++ b/arch/sandbox/cpu/os.c
> @@ -46,6 +46,17 @@ ssize_t os_read(int fd, void *buf, size_t count)
>         return read(fd, buf, count);
>  }
>
> +ssize_t os_get_blocksize(int fd)
> +{
> +       struct stat stat = {0};
> +       int ret;
> +
> +       ret = fstat(fd, &stat);
> +       if (ret < 0)
> +               return -errno;
> +       return stat.st_blksize;
> +}
> +
>  ssize_t os_write(int fd, const void *buf, size_t count)
>  {
>         return write(fd, buf, count);
> diff --git a/fs/fs.c b/fs/fs.c
> index 7e4ead9b790b..337d5711c28c 100644
> --- a/fs/fs.c
> +++ b/fs/fs.c
> @@ -261,7 +261,7 @@ static struct fstype_info fstypes[] = {
>                 .exists = sandbox_fs_exists,
>                 .size = sandbox_fs_size,
>                 .read = fs_read_sandbox,
> -               .get_blocksize = fs_get_blocksize_unsupported,
> +               .get_blocksize = sandbox_fs_get_blocksize,
>                 .write = fs_write_sandbox,
>                 .uuid = fs_uuid_unsupported,
>                 .opendir = fs_opendir_unsupported,
> diff --git a/fs/sandbox/sandboxfs.c b/fs/sandbox/sandboxfs.c
> index 4ae41d5b4db1..130fee088621 100644
> --- a/fs/sandbox/sandboxfs.c
> +++ b/fs/sandbox/sandboxfs.c
> @@ -55,6 +55,20 @@ int sandbox_fs_read_at(const char *filename, loff_t pos, void *buffer,
>         return ret;
>  }
>
> +int sandbox_fs_get_blocksize(const char *filename)
> +{
> +       int fd;
> +       int ret;
> +
> +       fd = os_open(filename, OS_O_RDONLY);
> +       if (fd < 0)
> +               return fd;
> +
> +       ret = os_get_blocksize(fd);
> +       os_close(fd);
> +       return ret;
> +}
> +
>  int sandbox_fs_write_at(const char *filename, loff_t pos, void *buffer,
>                         loff_t towrite, loff_t *actwrite)
>  {
> diff --git a/include/os.h b/include/os.h
> index 10e198cf503e..a864d9ca39b2 100644
> --- a/include/os.h
> +++ b/include/os.h
> @@ -26,6 +26,14 @@ struct sandbox_state;
>   */
>  ssize_t os_read(int fd, void *buf, size_t count);
>
> +/**
> + * Get the optimial blocksize through stat() call.
> + *
> + * @fd:                File descriptor as returned by os_open()
> + * Return:     >=0 for the blocksize. <0 for error.
> + */
> +ssize_t os_get_blocksize(int fd);
> +
>  /**
>   * Access to the OS write() system call
>   *
> diff --git a/include/sandboxfs.h b/include/sandboxfs.h
> index 783dd5c88a73..6937068f7b82 100644
> --- a/include/sandboxfs.h
> +++ b/include/sandboxfs.h
> @@ -32,6 +32,7 @@ void sandbox_fs_close(void);
>  int sandbox_fs_ls(const char *dirname);
>  int sandbox_fs_exists(const char *filename);
>  int sandbox_fs_size(const char *filename, loff_t *size);
> +int sandbox_fs_get_blocksize(const char *filename);

Please add a full comment.

>  int fs_read_sandbox(const char *filename, void *buf, loff_t offset, loff_t len,
>                     loff_t *actread);
>  int fs_write_sandbox(const char *filename, void *buf, loff_t offset,
> --
> 2.36.1
>

Regards,
Simon
