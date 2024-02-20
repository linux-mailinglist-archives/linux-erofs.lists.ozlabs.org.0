Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id C6AB685B135
	for <lists+linux-erofs@lfdr.de>; Tue, 20 Feb 2024 04:16:10 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=mbaynton-com.20230601.gappssmtp.com header.i=@mbaynton-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=JLagdATU;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Tf4L74xZVz3bwR
	for <lists+linux-erofs@lfdr.de>; Tue, 20 Feb 2024 14:15:59 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=mbaynton-com.20230601.gappssmtp.com header.i=@mbaynton-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=JLagdATU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=mbaynton.com (client-ip=2607:f8b0:4864:20::430; helo=mail-pf1-x430.google.com; envelope-from=mike@mbaynton.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Tf4L00RSTz3bYx
	for <linux-erofs@lists.ozlabs.org>; Tue, 20 Feb 2024 14:15:50 +1100 (AEDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-6e47c503fb5so91519b3a.2
        for <linux-erofs@lists.ozlabs.org>; Mon, 19 Feb 2024 19:15:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mbaynton-com.20230601.gappssmtp.com; s=20230601; t=1708398947; x=1709003747; darn=lists.ozlabs.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D4lbBZAA3fKotutWYRHL2mPU65t47tAHmQ+P8uNa43k=;
        b=JLagdATUFLvFY9M9Ayvo17TJHB9lTDDNWOK9i+nEJst3NHq95taZlVmT18R7SigeTJ
         80nObHFW5VProgaiEL7nJet6tNqIYcIK9sy59i+ySYiclBBEEVg7l3mSOZBGVlrdjyyW
         EzjU9LHQBJ1V3NuE7n0xY2B1iwF1cwJZraoUiwvQOlpfKqnRrT0nBcAFsF7t+Tm6fuIU
         cxdu+ppHrU4NjznVVOsELBIZmNhDLidxIobmd5T+2vs9s3IWSn9vJb9bzSkUqhNln3yY
         zRvub5cYEXMRSZhUp2nG1ETaymg6vDDIPUGpPyv63FFxyfjx82GTAwQYsYVbx6XfzAVB
         LGYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708398947; x=1709003747;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D4lbBZAA3fKotutWYRHL2mPU65t47tAHmQ+P8uNa43k=;
        b=t063VwBb9vm2SuOl4lkRVtcb+IsWSY9MpesYsgV8vmKKSnVQiKkCDuF93gIzyN8DAP
         y+vT/0iF5AJDd2FEVZ1OVge3IqizUcyvjEg5IMxJLQ36ACQ3Abz7ZMYo54uve3LshGIQ
         XZzKbtfcorafJFYmVAKObSchA4+dl9MElA2omwKZDhmm98RkjJkesHEVY6Qwpk5G8pXq
         p3Mtz4aG0+ULPT/oXH7SULdSQgNmU3GQocPK3ABmpCazDwPHkZo78uNzzA1nR/Wks9kx
         OCedo8a0yEJEtr2worGYsinCmNBiNo2DtZZgs5DWlb0Pq64A8o2CW3M43Qw19pWD4F37
         VtoQ==
X-Gm-Message-State: AOJu0YyRv+foKqLUb4LWE1P0Un80lOLhD2A8tstVgJngZFALjSXSMXCd
	WdCCKSGfQn66pXLVfebKPVMzPqx1cuiLEFZMNAwM46iilTSKIFu+88cZwQFEgebALvfxIyMMF5i
	Nsz/xzNnau9KY+upuU56TR0LsfdDX/JjAg90K11AZdTxhHO4J
X-Google-Smtp-Source: AGHT+IG51O8XVvSWUBvCPCeHCed2aEjN+dtH2YbPqOM2XAFxKF+bY8FkocU5CP3HJH++s5uoelPRO4LlEdTs8FMIyFQ=
X-Received: by 2002:a05:6a20:4f05:b0:19e:8b31:f1ae with SMTP id
 gi5-20020a056a204f0500b0019e8b31f1aemr13594036pzb.29.1708398946655; Mon, 19
 Feb 2024 19:15:46 -0800 (PST)
MIME-Version: 1.0
References: <CAM56kJTupW_WZapYM6YzFLPtriYb5+FU-Y8-mYY8ETGYfQmG6g@mail.gmail.com>
 <5d558d53-a1d8-4bfc-b2a3-a10cd941d786@linux.alibaba.com>
In-Reply-To: <5d558d53-a1d8-4bfc-b2a3-a10cd941d786@linux.alibaba.com>
From: Mike Baynton <mike@mbaynton.com>
Date: Mon, 19 Feb 2024 21:15:35 -0600
Message-ID: <CAM56kJSpyScSSodu9Liw-2Ws2NvXE8qEY1GpLa8oFFk1tOJDNA@mail.gmail.com>
Subject: Re: Feature request: erofs-utils mkfs: Efficient way to pipe only
 file metadata
To: linux-erofs@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hello Gao,
Thanks for your quick reply and thoughts on the matter. Yeah, formats
like those you referenced look like basically the right idea as well.

I did just want to point out a few requirements I have that I'd wager
would apply to anyone trying to use EROFS in the way I am. That is, to
use EROFS as a layer of an overlay filesystem that includes inodes for
each and every file required by an application or container, but that
uses xattrs interpreted by overlayfs to point to specific files
containing the desired data.

So the requirements are
1. Format needs to support xattrs in the input to mkfs.erofs.
2. Emphasis on performance of generating 10s of thousands of inodes
and dentries.

1. is because you must set trusted.overlay.redirect and
trusted.overlay.metacopy xattrs on each file. 2. is because those that
land at EROFS for this versus, say, just writing tens of thousands of
sparse files out to ext4, are probably here for the performance
(Making this part of the startup process for a container seems likely
for example, and container startups should be fast.)

So I actually think tar's header and extended header records format is
already better suited to the task. You can encode xattrs and, though
it might not be a major slowdown, you avoid converting things like
mode and file size to symbolic ascii representations and back. It's
also reasonably easy to find software to assist in correctly
generating these structures.

Regards,
Mike

On Sun, Feb 18, 2024 at 10:44=E2=80=AFPM Gao Xiang <hsiangkao@linux.alibaba=
.com> wrote:
>
> Hi Mike,
>
> On 2024/2/19 11:37, Mike Baynton wrote:
> > Hello erofs developers,
> > I am integrating erofs with overlayfs in a manner similar to what
> > composefs is doing. So, I am interested in making erofs images
> > containing only file metadata and extended attributes, but no file
> > data, as in $ mkfs.erofs --tar=3Di (thanks for that!)
>
> Thanks for your interest in EROFS too.
>
> >
> > However, I would like to construct the erofs image from a set of files
> > selected dynamically by another program. This leads me to prefer
> > sending an unseekable stream to mkfs.erofs so that file selection and
> > image generation can run concurrently, instead of first making a
> > complete tarball and then making the erofs image. In this case, it
> > becomes necessary to transfer each file's worth of data through the
> > stream after each header only so that the tarball reader in tar.c does
> > not become desynchronized with the expected offset of the next tar
> > header.
>
> I wonder if it's possible to use a modified prototype-like [1] format
> which mkfs.xfs [2] currently supports with "-p".  This prototype can
> be passed with a pipe instead.
>
> [1] http://uw714doc.sco.com/en/man/html.4/prototype.4.html
> [2] https://man7.org/linux/man-pages/man8/mkfs.xfs.8.html
>
> >
> > A very straightforward solution that seems to be working just fine for
> > me is to simply introduce a new optarg for --tar that indicates the
> > input data will be simply a series of tar headers / metadata without
> > actual file data. This implies index mode and additionally prevents
> > the skipping of inode.size worth of bytes after each header:
> >
> > diff --git a/include/erofs/tar.h b/include/erofs/tar.h
> > index a76f740..3d40a0f 100644
> > --- a/include/erofs/tar.h
> > +++ b/include/erofs/tar.h
> > @@ -46,7 +46,7 @@ struct erofs_tarfile {
> >
> >    int fd;
> >    u64 offset;
> > - bool index_mode, aufs;
> > + bool index_mode, headeronly_mode, aufs;
> >   };
> >
> >   void erofs_iostream_close(struct erofs_iostream *ios);
> > diff --git a/lib/tar.c b/lib/tar.c
> > index 8204939..e916395 100644
> > --- a/lib/tar.c
> > +++ b/lib/tar.c
> > @@ -584,7 +584,7 @@ static int tarerofs_write_file_index(struct
> > erofs_inode *inode,
> >    ret =3D tarerofs_write_chunkes(inode, data_offset);
> >    if (ret)
> >    return ret;
> > - if (erofs_iostream_lskip(&tar->ios, inode->i_size))
> > + if (!tar->headeronly_mode && erofs_iostream_lskip(&tar->ios, inode->i=
_size))
> >    return -EIO;
> >    return 0;
> >   }
> > diff --git a/mkfs/main.c b/mkfs/main.c
> > index 6d2b700..a72d30e 100644
> > --- a/mkfs/main.c
> > +++ b/mkfs/main.c
> > @@ -122,7 +122,7 @@ static void usage(void)
> >          " --max-extent-bytes=3D#  set maximum decompressed extent size=
 #
> > in bytes\n"
> >          " --preserve-mtime      keep per-file modification time strict=
ly\n"
> >          " --aufs                replace aufs special files with
> > overlayfs metadata\n"
> > -       " --tar=3D[fi]            generate an image from tarball(s)\n"
> > +       " --tar=3D[fih]           generate an image from tarball(s) or
> > tarball header data\n"
> >          " --ovlfs-strip=3D[01]    strip overlayfs metadata in the targ=
et
> > image (e.g. whiteouts)\n"
> >          " --quiet               quiet execution (do not write anything
> > to standard output.)\n"
> >   #ifndef NDEBUG
> > @@ -514,11 +514,13 @@ static int mkfs_parse_options_cfg(int argc, char =
*argv[])
> >    cfg.c_extra_ea_name_prefixes =3D true;
> >    break;
> >    case 20:
> > - if (optarg && (!strcmp(optarg, "i") ||
> > - !strcmp(optarg, "0") || !memcmp(optarg, "0,", 2))) {
> > + if (optarg && (!strcmp(optarg, "i") || (!strcmp(optarg, "h") ||
> > + !strcmp(optarg, "0") || !memcmp(optarg, "0,", 2)))) {
> >    erofstar.index_mode =3D true;
> >    if (!memcmp(optarg, "0,", 2))
> >    erofstar.mapfile =3D strdup(optarg + 2);
> > + if (!strcmp(optarg, "h"))
> > + erofstar.headeronly_mode =3D true;
> >    }
> >    tar_mode =3D true;
> >    break;
> >
> > Using this requires generation of tarball-ish streams that can be
> > slightly difficult to cajole tar libraries into creating, but it does
> > work if you do it. I can imagine much more complex alternative ways to
> > do this too, such as supporting sparse tar files or supporting some
> > whole new input format.
>
> I think you could just fill zero to use the current index mode now.
> But yes, it could be inefficient if some files are huge.
>
> >
> > Would some version of this feature be interesting and useful? If so,
> > is the simple way good enough? It wouldn't preclude future addition of
> > things like a sparse tar reader.
>
> Yes, I think it's useful to support a simple prototype-like format, but
> it might take time on my own since there are some other ongoing stuffs
> to be landed (like multi-threading mkfs support.)
>
> Thanks,
> Gao Xiang
>
> >
> > Regards,
> > Mike
