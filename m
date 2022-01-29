Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C5D84A2C06
	for <lists+linux-erofs@lfdr.de>; Sat, 29 Jan 2022 06:47:55 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Jm3JT0xX1z30R0
	for <lists+linux-erofs@lfdr.de>; Sat, 29 Jan 2022 16:47:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=mNkxw1T+;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::d31;
 helo=mail-io1-xd31.google.com; envelope-from=igoreisberg@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20210112 header.b=mNkxw1T+; dkim-atps=neutral
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com
 [IPv6:2607:f8b0:4864:20::d31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Jm3JP07YHz2ymb
 for <linux-erofs@lists.ozlabs.org>; Sat, 29 Jan 2022 16:47:47 +1100 (AEDT)
Received: by mail-io1-xd31.google.com with SMTP id 9so10380364iou.2
 for <linux-erofs@lists.ozlabs.org>; Fri, 28 Jan 2022 21:47:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=oTj4QSgH5l/f/Ul/NiSyvmD7e91W6CVs8SaotdONGdI=;
 b=mNkxw1T+0Sl3a3w0WYAPpyygJynxFpoJEavJ0p5LD9swbuuAq96zxNhpsqPGdDXcw0
 7RvcfpNhQ2hIawVenuPpELDgKLtlwRAegHlNLLVy+aseG12H/oxcb3NyWWh+/S7SDRej
 z666DC5AucSjVFWyrJYQvxE5v5tw7rPFk/q7dB4f5Bk9Mxo9fHkjsHUwq+BNDwIDCzaT
 tTTVY3njbR5JALYmsvi59kClG+0uOrLBV4h+wI6DcSYI40qD3PhnFHikt74sKGLEvy+Q
 1xWUyiK3n6tYQI53NBoKrwEKwJiGL79Q7D+4t7VuybUASL69KoSXZaTMdJDnbqte0YeV
 VwmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=oTj4QSgH5l/f/Ul/NiSyvmD7e91W6CVs8SaotdONGdI=;
 b=P2XovRwg70figkiBWZWn2RjTdsxSajiLngw+2Frqb2Ur7Qpy/k4rPgxs6LX9FLewLr
 D/+Z5ZqYuwtQKcmjrN9LeLNHYG56BtB3kTm2OzuBa/sezlniMcD8PpEd3VEiewxoJ0HF
 6FWKNwZjVlwMa/bn1IwFUkg/GZFjh97lHHecmdGqYpdBFJ/kFIrKAVTZKl1B1sBfyb6Z
 UwYmfKE1frXW591j+dfRps0LaE+ecNORn+8dxcC/lNTpoeHzxKH35YF82zj0NmxmfMxZ
 xSuifGocARnkdyxQPPh9I5FiDuwvN1FGsD4DZo43eozBypZdjL0bWshG1zEabhKOKZsC
 W1Ag==
X-Gm-Message-State: AOAM531UOGAyZgxMsBFZrXNxiV+B4rzwZLkMOqwDI8MwPIzh4VGkeXJ5
 1Efyz2pIfY/Sty/RD+hPG+ZWQASqlxk7qQXFPJw9gj+F5DAN4g==
X-Google-Smtp-Source: ABdhPJyP/3S4xanMmFCeDh62PWlzPB3wZrw6DQ3Sb2XisutkXS5/0pvpbMOnILjFKk6dfbWMpxmVtA27rhX7bG8ZHSo=
X-Received: by 2002:a05:6602:2492:: with SMTP id
 g18mr7090707ioe.24.1643435262017; 
 Fri, 28 Jan 2022 21:47:42 -0800 (PST)
MIME-Version: 1.0
References: <20220128132218.26-1-igoreisberg@gmail.com>
In-Reply-To: <20220128132218.26-1-igoreisberg@gmail.com>
From: Igor Eisberg <igoreisberg@gmail.com>
Date: Sat, 29 Jan 2022 07:47:31 +0200
Message-ID: <CABjEcnGhBLMd1wKC_hjQa8FuO6mFvmC3rxFCgi3fBr0omnymSQ@mail.gmail.com>
Subject: Re: [PATCH] erofs-utils: add missing errors and normalize errors to
 lower-case
To: linux-erofs@lists.ozlabs.org
Content-Type: multipart/alternative; boundary="00000000000001059505d6b217d5"
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

--00000000000001059505d6b217d5
Content-Type: text/plain; charset="UTF-8"

Point regarding conclusive messages taken, will revert the relevant lines.
As for the time variable, all I did was to match it to the format as in the
case of HAVE_UTIMENSAT, just above it.
Although the variable isn't used further, inlining it is unreadable.

You also changed this:

> ret = z_erofs_decompress(&(struct z_erofs_decompress_req) {
>
> .in = raw,
>
> .out = buffer,
>
> .decodedskip = 0,
>
> .inputsize = map.m_plen,
>
> .decodedlength = map.m_llen,
>
> .alg = map.m_algorithmformat,
>
> .partial_decoding = 0
>
> });
>
>
to this:

> struct z_erofs_decompress_req rq = {
>
> .in = raw,
>
> .out = buffer,
>
> .decodedskip = 0,
>
> .inputsize = map.m_plen,
>
> .decodedlength = map.m_llen,
>
> .alg = map.m_algorithmformat,
>
> .partial_decoding = 0
>
> };
>
>
>> ret = z_erofs_decompress(&rq);
>
>
Although that variable could have remained avoided, like in lib/data.c,
where it's still avoided:

> ret = z_erofs_decompress(&(struct z_erofs_decompress_req) {
>
> .in = raw,
>
> .out = buffer + end - offset,
>
> .decodedskip = skip,
>
> .inputsize = map.m_plen,
>
> .decodedlength = length,
>
> .alg = map.m_algorithmformat,
>
> .partial_decoding = partial
>
> });
>
>
It's just that inconsistency in code style is an eyesore. ;)

On Fri, 28 Jan 2022 at 15:22, Igor Ostapenko <igoreisberg@gmail.com> wrote:

> From: Igor Eisberg <igoreisberg@gmail.com>
>
> * Added useful error messages.
> * Most errors start with lower-case, let's make all of them lower-case
>   for better consistency.
>
> Signed-off-by: Igor Ostapenko <igoreisberg@gmail.com>
> ---
>  dump/main.c |  4 +++-
>  fsck/main.c | 35 +++++++++++++++++++++++------------
>  mkfs/main.c | 32 +++++++++++++++++---------------
>  3 files changed, 43 insertions(+), 28 deletions(-)
>
> diff --git a/dump/main.c b/dump/main.c
> index 0616113..664780b 100644
> --- a/dump/main.c
> +++ b/dump/main.c
> @@ -162,8 +162,10 @@ static int erofsdump_parse_options_cfg(int argc, char
> **argv)
>                 }
>         }
>
> -       if (optind >= argc)
> +       if (optind >= argc) {
> +               erofs_err("missing argument: IMAGE");
>                 return -EINVAL;
> +       }
>
>         cfg.c_img_path = strdup(argv[optind++]);
>         if (!cfg.c_img_path)
> diff --git a/fsck/main.c b/fsck/main.c
> index 6f17d0e..5667f2a 100644
> --- a/fsck/main.c
> +++ b/fsck/main.c
> @@ -202,8 +202,10 @@ static int erofsfsck_parse_options_cfg(int argc, char
> **argv)
>                 }
>         }
>
> -       if (optind >= argc)
> +       if (optind >= argc) {
> +               erofs_err("missing argument: IMAGE");
>                 return -EINVAL;
> +       }
>
>         cfg.c_img_path = strdup(argv[optind++]);
>         if (!cfg.c_img_path)
> @@ -230,8 +232,12 @@ static void erofsfsck_set_attributes(struct
> erofs_inode *inode, char *path)
>
>         if (utimensat(AT_FDCWD, path, times, AT_SYMLINK_NOFOLLOW) < 0)
>  #else
> -       if (utime(path, &((struct utimbuf){.actime = inode->i_ctime,
> -                                          .modtime = inode->i_ctime})) <
> 0)
> +       const struct utimbuf time = {
> +               .actime = inode->i_ctime,
> +               .modtime = inode->i_ctime,
> +       };
> +
> +       if (utime(path, &time) < 0)
>  #endif
>                 erofs_warn("failed to set times: %s", path);
>
> @@ -512,7 +518,7 @@ static inline int erofs_extract_dir(struct erofs_inode
> *inode)
>                 struct stat st;
>
>                 if (errno != EEXIST) {
> -                       erofs_err("failed to create directory %s: %s",
> +                       erofs_err("failed to create directory: %s (%s)",
>                                   fsckcfg.extract_path, strerror(errno));
>                         return -errno;
>                 }
> @@ -528,8 +534,11 @@ static inline int erofs_extract_dir(struct
> erofs_inode *inode)
>                  * Try to change permissions of existing directory so
>                  * that we can write to it
>                  */
> -               if (chmod(fsckcfg.extract_path, 0700) < 0)
> +               if (chmod(fsckcfg.extract_path, 0700) < 0) {
> +                       erofs_err("failed to set permissions: %s (%s)",
> +                                 fsckcfg.extract_path, strerror(errno));
>                         return -errno;
> +               }
>         }
>         return 0;
>  }
> @@ -551,18 +560,20 @@ again:
>                                 erofs_warn("try to forcely remove
> directory %s",
>                                            fsckcfg.extract_path);
>                                 if (rmdir(fsckcfg.extract_path) < 0) {
> -                                       erofs_err("failed to remove: %s",
> -                                                 fsckcfg.extract_path);
> +                                       erofs_err("failed to remove: %s
> (%s)",
> +                                                 fsckcfg.extract_path,
> strerror(errno));
>                                         return -EISDIR;
>                                 }
>                         } else if (errno == EACCES &&
>                                    chmod(fsckcfg.extract_path, 0700) < 0) {
> +                               erofs_err("failed to set permissions: %s
> (%s)",
> +                                         fsckcfg.extract_path,
> strerror(errno));
>                                 return -errno;
>                         }
>                         tryagain = false;
>                         goto again;
>                 }
> -               erofs_err("failed to open %s: %s", fsckcfg.extract_path,
> +               erofs_err("failed to open: %s (%s)", fsckcfg.extract_path,
>                           strerror(errno));
>                 return -errno;
>         }
> @@ -768,15 +779,15 @@ int main(int argc, char **argv)
>         err = erofsfsck_check_inode(sbi.root_nid, sbi.root_nid);
>         if (fsckcfg.corrupted) {
>                 if (!fsckcfg.extract_path)
> -                       erofs_err("Found some filesystem corruption");
> +                       erofs_err("found some filesystem corruption");
>                 else
> -                       erofs_err("Failed to extract filesystem");
> +                       erofs_err("failed to extract filesystem");
>                 err = -EFSCORRUPTED;
>         } else if (!err) {
>                 if (!fsckcfg.extract_path)
> -                       erofs_info("No error found");
> +                       erofs_info("no errors found");
>                 else
> -                       erofs_info("Extract data successfully");
> +                       erofs_info("extracted filesystem successfully");
>
>                 if (fsckcfg.print_comp_ratio) {
>                         double comp_ratio =
> diff --git a/mkfs/main.c b/mkfs/main.c
> index c755da1..dd698ff 100644
> --- a/mkfs/main.c
> +++ b/mkfs/main.c
> @@ -381,9 +381,6 @@ static int mkfs_parse_options_cfg(int argc, char
> *argv[])
>                 }
>         }
>
> -       if (optind >= argc)
> -               return -EINVAL;
> -
>         if (cfg.c_blobdev_path && cfg.c_chunkbits < LOG_BLOCK_SIZE) {
>                 erofs_err("--blobdev must be used together with
> --chunksize");
>                 return -EINVAL;
> @@ -396,24 +393,29 @@ static int mkfs_parse_options_cfg(int argc, char
> *argv[])
>                 return -EINVAL;
>         }
>
> +       if (optind >= argc) {
> +               erofs_err("missing argument: FILE");
> +               return -EINVAL;
> +       }
> +
>         cfg.c_img_path = strdup(argv[optind++]);
>         if (!cfg.c_img_path)
>                 return -ENOMEM;
>
>         if (optind >= argc) {
> -               erofs_err("Source directory is missing");
> +               erofs_err("missing argument: DIRECTORY");
>                 return -EINVAL;
>         }
>
>         cfg.c_src_path = realpath(argv[optind++], NULL);
>         if (!cfg.c_src_path) {
> -               erofs_err("Failed to parse source directory: %s",
> +               erofs_err("failed to parse source directory: %s",
>                           erofs_strerror(-errno));
>                 return -ENOENT;
>         }
>
>         if (optind < argc) {
> -               erofs_err("Unexpected argument: %s\n", argv[optind]);
> +               erofs_err("unexpected argument: %s\n", argv[optind]);
>                 return -EINVAL;
>         }
>         if (quiet)
> @@ -456,7 +458,7 @@ int erofs_mkfs_update_super_block(struct
> erofs_buffer_head *bh,
>
>         buf = calloc(sb_blksize, 1);
>         if (!buf) {
> -               erofs_err("Failed to allocate memory for sb: %s",
> +               erofs_err("failed to allocate memory for sb: %s",
>                           erofs_strerror(-errno));
>                 return -ENOMEM;
>         }
> @@ -538,7 +540,7 @@ int parse_source_date_epoch(void)
>
>         epoch = strtoull(source_date_epoch, &endptr, 10);
>         if (epoch == -1ULL || *endptr != '\0') {
> -               erofs_err("Environment variable $SOURCE_DATE_EPOCH %s is
> invalid",
> +               erofs_err("environment variable $SOURCE_DATE_EPOCH %s is
> invalid",
>                           source_date_epoch);
>                 return -EINVAL;
>         }
> @@ -641,34 +643,34 @@ int main(int argc, char **argv)
>         sb_bh = erofs_buffer_init();
>         if (IS_ERR(sb_bh)) {
>                 err = PTR_ERR(sb_bh);
> -               erofs_err("Failed to initialize buffers: %s",
> +               erofs_err("failed to initialize buffers: %s",
>                           erofs_strerror(err));
>                 goto exit;
>         }
>         err = erofs_bh_balloon(sb_bh, EROFS_SUPER_END);
>         if (err < 0) {
> -               erofs_err("Failed to balloon erofs_super_block: %s",
> +               erofs_err("failed to balloon erofs_super_block: %s",
>                           erofs_strerror(err));
>                 goto exit;
>         }
>
>         err = erofs_load_compress_hints();
>         if (err) {
> -               erofs_err("Failed to load compress hints %s",
> +               erofs_err("failed to load compress hints %s",
>                           cfg.c_compress_hints_file);
>                 goto exit;
>         }
>
>         err = z_erofs_compress_init(sb_bh);
>         if (err) {
> -               erofs_err("Failed to initialize compressor: %s",
> +               erofs_err("failed to initialize compressor: %s",
>                           erofs_strerror(err));
>                 goto exit;
>         }
>
>         err = erofs_generate_devtable();
>         if (err) {
> -               erofs_err("Failed to generate device table: %s",
> +               erofs_err("failed to generate device table: %s",
>                           erofs_strerror(err));
>                 goto exit;
>         }
> @@ -681,7 +683,7 @@ int main(int argc, char **argv)
>
>         err = erofs_build_shared_xattrs_from_path(cfg.c_src_path);
>         if (err) {
> -               erofs_err("Failed to build shared xattrs: %s",
> +               erofs_err("failed to build shared xattrs: %s",
>                           erofs_strerror(err));
>                 goto exit;
>         }
> @@ -727,7 +729,7 @@ exit:
>         erofs_exit_configure();
>
>         if (err) {
> -               erofs_err("\tCould not format the device : %s\n",
> +               erofs_err("\tcould not format the device : %s\n",
>                           erofs_strerror(err));
>                 return 1;
>         }
> --
> 2.30.2
>
>

--00000000000001059505d6b217d5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div>Po=
int regarding conclusive messages taken, will revert the relevant lines.</d=
iv><div dir=3D"ltr">As for the time variable, all I did was to match it to =
the format as in the case of HAVE_UTIMENSAT, just above it.</div><div>Altho=
ugh the variable=C2=A0isn&#39;t used further, inlining it is unreadable.</d=
iv><div dir=3D"ltr"><br></div><div>You also changed this:</div><blockquote =
class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px sol=
id rgb(204,204,204);padding-left:1ex"><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddi=
ng-left:1ex">ret =3D z_erofs_decompress(&amp;(struct z_erofs_decompress_req=
) {</blockquote><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><span sty=
le=3D"white-space:pre">			</span>.in =3D raw,</blockquote><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex"><span style=3D"white-space:pre">			</span>=
.out =3D buffer,</blockquote><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1=
ex"><span style=3D"white-space:pre">			</span>.decodedskip =3D 0,</blockquo=
te><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bord=
er-left:1px solid rgb(204,204,204);padding-left:1ex"><span style=3D"white-s=
pace:pre">			</span>.inputsize =3D map.m_plen,</blockquote><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid r=
gb(204,204,204);padding-left:1ex"><span style=3D"white-space:pre">			</span=
>.decodedlength =3D map.m_llen,</blockquote><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex"><span style=3D"white-space:pre">			</span>.alg =3D map.m=
_algorithmformat,</blockquote><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:=
1ex"><span style=3D"white-space:pre">			</span>.partial_decoding =3D 0</blo=
ckquote><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex=
;border-left:1px solid rgb(204,204,204);padding-left:1ex"><span style=3D"wh=
ite-space:pre">			</span> });</blockquote></blockquote><div>=C2=A0</div><di=
v>to this:</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex">struct z_erofs_decompress_req rq =
=3D {</blockquote><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px=
 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><span s=
tyle=3D"white-space:pre">	</span>.in =3D raw,</blockquote><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex"><span style=3D"white-space:pre">	</span>.o=
ut =3D buffer,</blockquote><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
"><span style=3D"white-space:pre">	</span>.decodedskip =3D 0,</blockquote><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex"><span style=3D"white-space=
:pre">	</span>.inputsize =3D map.m_plen,</blockquote><blockquote class=3D"g=
mail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204=
,204,204);padding-left:1ex"><span style=3D"white-space:pre">	</span>.decode=
dlength =3D map.m_llen,</blockquote><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex"><span style=3D"white-space:pre">	</span>.alg =3D map.m_algorithm=
format,</blockquote><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><span=
 style=3D"white-space:pre">	</span>.partial_decoding =3D 0</blockquote><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left=
:1px solid rgb(204,204,204);padding-left:1ex">};</blockquote><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex"><br></blockquote><blockquote class=3D"g=
mail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204=
,204,204);padding-left:1ex">ret =3D z_erofs_decompress(&amp;rq);</blockquot=
e></blockquote><div><br></div><div>Although that variable could have remain=
ed avoided, like in lib/data.c, where it&#39;s still avoided:</div><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px=
 solid rgb(204,204,204);padding-left:1ex"><blockquote class=3D"gmail_quote"=
 style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);p=
adding-left:1ex">ret =3D z_erofs_decompress(&amp;(struct z_erofs_decompress=
_req) {</blockquote><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><span=
 style=3D"white-space:pre">			</span>.in =3D raw,</blockquote><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px soli=
d rgb(204,204,204);padding-left:1ex"><span style=3D"white-space:pre">			</s=
pan>.out =3D buffer + end - offset,</blockquote><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,=
204);padding-left:1ex"><span style=3D"white-space:pre">			</span>.decodedsk=
ip =3D skip,</blockquote><blockquote class=3D"gmail_quote" style=3D"margin:=
0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">=
<span style=3D"white-space:pre">			</span>.inputsize =3D map.m_plen,</block=
quote><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;b=
order-left:1px solid rgb(204,204,204);padding-left:1ex"><span style=3D"whit=
e-space:pre">			</span>.decodedlength =3D length,</blockquote><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px soli=
d rgb(204,204,204);padding-left:1ex"><span style=3D"white-space:pre">			</s=
pan>.alg =3D map.m_algorithmformat,</blockquote><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,=
204);padding-left:1ex"><span style=3D"white-space:pre">			</span>.partial_d=
ecoding =3D partial</blockquote><blockquote class=3D"gmail_quote" style=3D"=
margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-lef=
t:1ex"><span style=3D"white-space:pre">			</span> });</blockquote></blockqu=
ote><div><br></div><div>It&#39;s just that inconsistency in code style is a=
n eyesore. ;)=C2=A0</div></div></div></div></div><br><div class=3D"gmail_qu=
ote"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, 28 Jan 2022 at 15:22, Ig=
or Ostapenko &lt;<a href=3D"mailto:igoreisberg@gmail.com">igoreisberg@gmail=
.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1=
ex">From: Igor Eisberg &lt;<a href=3D"mailto:igoreisberg@gmail.com" target=
=3D"_blank">igoreisberg@gmail.com</a>&gt;<br>
<br>
* Added useful error messages.<br>
* Most errors start with lower-case, let&#39;s make all of them lower-case<=
br>
=C2=A0 for better consistency.<br>
<br>
Signed-off-by: Igor Ostapenko &lt;<a href=3D"mailto:igoreisberg@gmail.com" =
target=3D"_blank">igoreisberg@gmail.com</a>&gt;<br>
---<br>
=C2=A0dump/main.c |=C2=A0 4 +++-<br>
=C2=A0fsck/main.c | 35 +++++++++++++++++++++++------------<br>
=C2=A0mkfs/main.c | 32 +++++++++++++++++---------------<br>
=C2=A03 files changed, 43 insertions(+), 28 deletions(-)<br>
<br>
diff --git a/dump/main.c b/dump/main.c<br>
index 0616113..664780b 100644<br>
--- a/dump/main.c<br>
+++ b/dump/main.c<br>
@@ -162,8 +162,10 @@ static int erofsdump_parse_options_cfg(int argc, char =
**argv)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (optind &gt;=3D argc)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (optind &gt;=3D argc) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0erofs_err(&quot;mis=
sing argument: IMAGE&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EINVAL;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 cfg.c_img_path =3D strdup(argv[optind++]);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!cfg.c_img_path)<br>
diff --git a/fsck/main.c b/fsck/main.c<br>
index 6f17d0e..5667f2a 100644<br>
--- a/fsck/main.c<br>
+++ b/fsck/main.c<br>
@@ -202,8 +202,10 @@ static int erofsfsck_parse_options_cfg(int argc, char =
**argv)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (optind &gt;=3D argc)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (optind &gt;=3D argc) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0erofs_err(&quot;mis=
sing argument: IMAGE&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EINVAL;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 cfg.c_img_path =3D strdup(argv[optind++]);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!cfg.c_img_path)<br>
@@ -230,8 +232,12 @@ static void erofsfsck_set_attributes(struct erofs_inod=
e *inode, char *path)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (utimensat(AT_FDCWD, path, times, AT_SYMLINK=
_NOFOLLOW) &lt; 0)<br>
=C2=A0#else<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (utime(path, &amp;((struct utimbuf){.actime =
=3D inode-&gt;i_ctime,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .=
modtime =3D inode-&gt;i_ctime})) &lt; 0)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0const struct utimbuf time =3D {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.actime =3D inode-&=
gt;i_ctime,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.modtime =3D inode-=
&gt;i_ctime,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0};<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (utime(path, &amp;time) &lt; 0)<br>
=C2=A0#endif<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 erofs_warn(&quot;fa=
iled to set times: %s&quot;, path);<br>
<br>
@@ -512,7 +518,7 @@ static inline int erofs_extract_dir(struct erofs_inode =
*inode)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct stat st;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (errno !=3D EEXI=
ST) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0erofs_err(&quot;failed to create directory %s: %s&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0erofs_err(&quot;failed to create directory: %s (%s)&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fsckcfg.extract_path, strerro=
r(errno));<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 return -errno;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
@@ -528,8 +534,11 @@ static inline int erofs_extract_dir(struct erofs_inode=
 *inode)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Try to chan=
ge permissions of existing directory so<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* that we can=
 write to it<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (chmod(fsckcfg.e=
xtract_path, 0700) &lt; 0)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (chmod(fsckcfg.e=
xtract_path, 0700) &lt; 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0erofs_err(&quot;failed to set permissions: %s (%s)&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fsckcfg.extract_path, strerror=
(errno));<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 return -errno;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
=C2=A0}<br>
@@ -551,18 +560,20 @@ again:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 erofs_warn(&quot;try to forcely remo=
ve directory %s&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0fsckcfg.extract_path);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (rmdir(fsckcfg.extract_path) &lt;=
 0) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0erofs_err=
(&quot;failed to remove: %s&quot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0fsckcfg.extract_path);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0erofs_err=
(&quot;failed to remove: %s (%s)&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0fsckcfg.extract_path, strerror(errno));<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -=
EISDIR;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 } else if (errno =3D=3D EACCES &amp;&amp;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0chmod(fsckcfg.extract_p=
ath, 0700) &lt; 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0erofs_err(&quot;failed to set permiss=
ions: %s (%s)&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fs=
ckcfg.extract_path, strerror(errno));<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -errno;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 tryagain =3D false;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 goto again;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0erofs_err(&quot;fai=
led to open %s: %s&quot;, fsckcfg.extract_path,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0erofs_err(&quot;fai=
led to open: %s (%s)&quot;, fsckcfg.extract_path,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 strerror(errno));<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -errno;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
@@ -768,15 +779,15 @@ int main(int argc, char **argv)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 err =3D erofsfsck_check_inode(sbi.root_nid, sbi=
.root_nid);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (fsckcfg.corrupted) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!fsckcfg.extrac=
t_path)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0erofs_err(&quot;Found some filesystem corruption&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0erofs_err(&quot;found some filesystem corruption&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0erofs_err(&quot;Failed to extract filesystem&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0erofs_err(&quot;failed to extract filesystem&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 err =3D -EFSCORRUPT=
ED;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else if (!err) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!fsckcfg.extrac=
t_path)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0erofs_info(&quot;No error found&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0erofs_info(&quot;no errors found&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0erofs_info(&quot;Extract data successfully&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0erofs_info(&quot;extracted filesystem successfully&quot;);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (fsckcfg.print_c=
omp_ratio) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 double comp_ratio =3D<br>
diff --git a/mkfs/main.c b/mkfs/main.c<br>
index c755da1..dd698ff 100644<br>
--- a/mkfs/main.c<br>
+++ b/mkfs/main.c<br>
@@ -381,9 +381,6 @@ static int mkfs_parse_options_cfg(int argc, char *argv[=
])<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (optind &gt;=3D argc)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;<br>
-<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (cfg.c_blobdev_path &amp;&amp; cfg.c_chunkbi=
ts &lt; LOG_BLOCK_SIZE) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 erofs_err(&quot;--b=
lobdev must be used together with --chunksize&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EINVAL;<br>
@@ -396,24 +393,29 @@ static int mkfs_parse_options_cfg(int argc, char *arg=
v[])<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EINVAL;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (optind &gt;=3D argc) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0erofs_err(&quot;mis=
sing argument: FILE&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 cfg.c_img_path =3D strdup(argv[optind++]);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!cfg.c_img_path)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -ENOMEM;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (optind &gt;=3D argc) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0erofs_err(&quot;Sou=
rce directory is missing&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0erofs_err(&quot;mis=
sing argument: DIRECTORY&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EINVAL;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 cfg.c_src_path =3D realpath(argv[optind++], NUL=
L);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!cfg.c_src_path) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0erofs_err(&quot;Fai=
led to parse source directory: %s&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0erofs_err(&quot;fai=
led to parse source directory: %s&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 erofs_strerror(-errno));<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -ENOENT;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (optind &lt; argc) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0erofs_err(&quot;Une=
xpected argument: %s\n&quot;, argv[optind]);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0erofs_err(&quot;une=
xpected argument: %s\n&quot;, argv[optind]);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EINVAL;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (quiet)<br>
@@ -456,7 +458,7 @@ int erofs_mkfs_update_super_block(struct erofs_buffer_h=
ead *bh,<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 buf =3D calloc(sb_blksize, 1);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!buf) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0erofs_err(&quot;Fai=
led to allocate memory for sb: %s&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0erofs_err(&quot;fai=
led to allocate memory for sb: %s&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 erofs_strerror(-errno));<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -ENOMEM;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
@@ -538,7 +540,7 @@ int parse_source_date_epoch(void)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 epoch =3D strtoull(source_date_epoch, &amp;endp=
tr, 10);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (epoch =3D=3D -1ULL || *endptr !=3D &#39;\0&=
#39;) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0erofs_err(&quot;Env=
ironment variable $SOURCE_DATE_EPOCH %s is invalid&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0erofs_err(&quot;env=
ironment variable $SOURCE_DATE_EPOCH %s is invalid&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 source_date_epoch);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EINVAL;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
@@ -641,34 +643,34 @@ int main(int argc, char **argv)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 sb_bh =3D erofs_buffer_init();<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (IS_ERR(sb_bh)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 err =3D PTR_ERR(sb_=
bh);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0erofs_err(&quot;Fai=
led to initialize buffers: %s&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0erofs_err(&quot;fai=
led to initialize buffers: %s&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 erofs_strerror(err));<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto exit;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 err =3D erofs_bh_balloon(sb_bh, EROFS_SUPER_END=
);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (err &lt; 0) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0erofs_err(&quot;Fai=
led to balloon erofs_super_block: %s&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0erofs_err(&quot;fai=
led to balloon erofs_super_block: %s&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 erofs_strerror(err));<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto exit;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 err =3D erofs_load_compress_hints();<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (err) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0erofs_err(&quot;Fai=
led to load compress hints %s&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0erofs_err(&quot;fai=
led to load compress hints %s&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 cfg.c_compress_hints_file);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto exit;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 err =3D z_erofs_compress_init(sb_bh);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (err) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0erofs_err(&quot;Fai=
led to initialize compressor: %s&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0erofs_err(&quot;fai=
led to initialize compressor: %s&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 erofs_strerror(err));<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto exit;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 err =3D erofs_generate_devtable();<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (err) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0erofs_err(&quot;Fai=
led to generate device table: %s&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0erofs_err(&quot;fai=
led to generate device table: %s&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 erofs_strerror(err));<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto exit;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
@@ -681,7 +683,7 @@ int main(int argc, char **argv)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 err =3D erofs_build_shared_xattrs_from_path(cfg=
.c_src_path);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (err) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0erofs_err(&quot;Fai=
led to build shared xattrs: %s&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0erofs_err(&quot;fai=
led to build shared xattrs: %s&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 erofs_strerror(err));<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto exit;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
@@ -727,7 +729,7 @@ exit:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 erofs_exit_configure();<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (err) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0erofs_err(&quot;\tC=
ould not format the device : %s\n&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0erofs_err(&quot;\tc=
ould not format the device : %s\n&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 erofs_strerror(err));<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 1;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-- <br>
2.30.2<br>
<br>
</blockquote></div>

--00000000000001059505d6b217d5--
