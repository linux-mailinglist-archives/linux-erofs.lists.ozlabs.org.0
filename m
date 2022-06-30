Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id D24DB561741
	for <lists+linux-erofs@lfdr.de>; Thu, 30 Jun 2022 12:07:05 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4LYYsH0Fffz3cSh
	for <lists+linux-erofs@lfdr.de>; Thu, 30 Jun 2022 20:06:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=eM8w+A7l;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2607:f8b0:4864:20::22f; helo=mail-oi1-x22f.google.com; envelope-from=sjg@google.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=eM8w+A7l;
	dkim-atps=neutral
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4LYYs50pTzz3bls
	for <linux-erofs@lists.ozlabs.org>; Thu, 30 Jun 2022 20:06:47 +1000 (AEST)
Received: by mail-oi1-x22f.google.com with SMTP id r82so16658199oig.2
        for <linux-erofs@lists.ozlabs.org>; Thu, 30 Jun 2022 03:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e8pqWGqhVSTyO+c06A/bQvR/DDZgQMwn4y9YfEG92Ro=;
        b=eM8w+A7lkkJ8DifuWcwsOyVlev56tH1FXe5QwRJ6ZkTQ6UmeyR9Z9tNE7FN4HXbdMw
         PNmJwsxO2cUzw1RlZMgJ64V8W5zK1c066lch2vvC8HMRqVj2+HUmoKsSMpaudNyUECqn
         I17DtADw1CL73goryaQSgm/RraoZh8QfnLlFY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e8pqWGqhVSTyO+c06A/bQvR/DDZgQMwn4y9YfEG92Ro=;
        b=c1jmNbg28CeAxp0iFNdzwwyL3GaFAqx6ULGn6npCDAsOVmXPD+F2y0084T90jlqJuV
         mzVRtPrYcvR9WT19Gtp7Vxumdfw8G1MFnEGk9RZUBbiqSqAD/UKC7cXKaTGz4s140TZj
         +5Z7IdwxkKhkycBk07C9nmno0DeA9/pcT5WS7ACB4U3cypTC3NE3k4mWsioripGP52+W
         sx8Zty5m2dPFG+HXRB8fT5xSibWdgfEOFw2Pf7i+MUJVsYpo4m87pcTQT2uZKF/QswZh
         /V37bUDD8fqIQ2Ivt1y1ATidWdUdET70Bp/6+SKh4cJqeCWhanZamjtqEoXPM9odnQ0p
         wSPg==
X-Gm-Message-State: AJIora/5geSUmLmFOIagMezrnGxbgLx79Q9qTt91kR3WTKaQFhzW5kbk
	NEfqP0tmln/nLgR8doxI4YKAFylEBGpSDEXdFSizfQ==
X-Google-Smtp-Source: AGRyM1unGJmin2EBpwJfMHodCEGvOafCOX7hWEyyUOUw3lRCT55Pgc4ai5auQ6F8gdIQ9XQOpyqnC/T+9rwPSX4uOJw=
X-Received: by 2002:a05:6808:189b:b0:335:caca:ca0b with SMTP id
 bi27-20020a056808189b00b00335cacaca0bmr620705oib.170.1656583605473; Thu, 30
 Jun 2022 03:06:45 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1656401086.git.wqu@suse.com> <b28b8d554dd3d1fc6bed8fc7f5b9cb71e1880e38.1656401086.git.wqu@suse.com>
In-Reply-To: <b28b8d554dd3d1fc6bed8fc7f5b9cb71e1880e38.1656401086.git.wqu@suse.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 30 Jun 2022 04:06:27 -0600
Message-ID: <CAPnjgZ1JLqXa6fexJFkh8aaj7h4OocBBOWat-fsp_x-zNrYO9g@mail.gmail.com>
Subject: Re: [PATCH RFC 1/8] fs: fat: unexport file_fat_read_at()
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
> That function is only utilized inside fat driver, unexport it.
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/fat/fat.c  | 4 ++--
>  include/fat.h | 2 --
>  2 files changed, 2 insertions(+), 4 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>


>
> diff --git a/fs/fat/fat.c b/fs/fat/fat.c
> index df9ea2c028fc..dcceccbcee0a 100644
> --- a/fs/fat/fat.c
> +++ b/fs/fat/fat.c
> @@ -1243,8 +1243,8 @@ out_free_itr:
>         return ret;
>  }
>
> -int file_fat_read_at(const char *filename, loff_t pos, void *buffer,
> -                    loff_t maxsize, loff_t *actread)
> +static int file_fat_read_at(const char *filename, loff_t pos, void *buffer,
> +                           loff_t maxsize, loff_t *actread)
>  {
>         fsdata fsdata;
>         fat_itr *itr;
> diff --git a/include/fat.h b/include/fat.h
> index bd8e450b33a3..a9756fb4cd1b 100644
> --- a/include/fat.h
> +++ b/include/fat.h
> @@ -200,8 +200,6 @@ static inline u32 sect_to_clust(fsdata *fsdata, int sect)
>  int file_fat_detectfs(void);
>  int fat_exists(const char *filename);
>  int fat_size(const char *filename, loff_t *size);
> -int file_fat_read_at(const char *filename, loff_t pos, void *buffer,
> -                    loff_t maxsize, loff_t *actread);
>  int file_fat_read(const char *filename, void *buffer, int maxsize);
>  int fat_set_blk_dev(struct blk_desc *rbdd, struct disk_partition *info);
>  int fat_register_device(struct blk_desc *dev_desc, int part_no);
> --
> 2.36.1
>
