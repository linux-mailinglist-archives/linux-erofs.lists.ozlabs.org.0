Return-Path: <linux-erofs+bounces-1475-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 385C5C99F3A
	for <lists+linux-erofs@lfdr.de>; Tue, 02 Dec 2025 04:18:49 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dL5Zv0JnTz3blC;
	Tue, 02 Dec 2025 14:18:47 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1764645526;
	cv=none; b=ZtjGx7gizoN58g2dHOSvWGVH/YMlXMKl8RrLwmvxuwg9QiIWlPHDYWgxbYHej7RrgYJviZUxfus8VBABwxYxjf4NHzOWSWGhTmOLa5Jdt1T4joJOB+GV0lHR2QnU8ffmoAW5FGrZ4R8WIr5w0VNeMj4mS4XD+hutiP3nw3h7NYqM5wyLdt23iW1aT3U3oyfRfvTrJSlqfTsi9KqxSJRJhRzydGxxyj2jwni2EMCIpFWSbCyXbtsjc8Z6rJBEIHYyd29sEpOMbA9k8b2h1qsn5OLZeI0Pdys7I+CczLnTjhMCnW9qJ8E3q4k+jElxYdsuRq0NUqXakpBDD02SMvmySg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1764645526; c=relaxed/relaxed;
	bh=Hxqn43FB22SlYYWeNWWpT8g7jD0BerLBvTO/Za22ZJ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fyWZNrjP6KnAj7WabwnrbCYO1aoiSyt1UVMtQgCaT4ARXZezG2cl6KsrMlb24aiyu9TIT7LsaM5wei3L2orjA+ng6wdMWlTEwx8UXcvwVYW5ZpFnZD3iBMz57ereNWmllfYlXtSnPQ1sKUIyABhagfyT7YPGxL7M4ex7wuJTPWI3fMlepnCbCmi3nezlojmm2UeRzdKb7YaFhZBAtZhfmFfKkt8+VoQkZsvrwPkHPuNrRmhSoCGJBVProIiT5fsmPTEMasqu5R1lOiNd/EaSERMyyOkBIpq+EO3d6Z6G8v93FmOlgpgqDfPSQwtvEDvykSnbpwrX+AjD662a4jMXQQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=yrvtZFj2; dkim-atps=neutral; spf=pass (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=yrvtZFj2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dL5Zq72Vtz3bfR
	for <linux-erofs@lists.ozlabs.org>; Tue, 02 Dec 2025 14:18:42 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1764645518; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Hxqn43FB22SlYYWeNWWpT8g7jD0BerLBvTO/Za22ZJ8=;
	b=yrvtZFj2IHySx+zUvwTDhROlQQSjHoUUDOaMnV0OeapqM8BAKJ2wJM/wpkTPVf0g+KfpW0XPfR36RmvxB4/OYVqwA5dMG74prK7oHdOKJUNYdTdgDmlVl7EaB8NfpPEKSm5cLQ9kjhu1zJOl3FS59/Th8gsTjfYh1kWtvTQxIwo=
Received: from 30.221.131.182(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WtudE1o_1764645516 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 02 Dec 2025 11:18:37 +0800
Message-ID: <2d40e3f6-a290-4a8b-8e64-f3bc870e917d@linux.alibaba.com>
Date: Tue, 2 Dec 2025 11:18:36 +0800
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mount.erofs: add manpage and usage information
To: ChengyuZhu6 <hudson@cyzhu.com>, linux-erofs@lists.ozlabs.org
Cc: Chengyu Zhu <hudsonzhu@tencent.com>
References: <20251130033516.86065-1-hudson@cyzhu.com>
 <20251202030807.55673-1-hudson@cyzhu.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20251202030807.55673-1-hudson@cyzhu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/12/2 11:08, ChengyuZhu6 wrote:
> From: Chengyu Zhu <hudsonzhu@tencent.com>
> 
> Add manpage, command-line usage help, and README for
> mount.erofs tool.
> 
> Signed-off-by: Chengyu Zhu <hudsonzhu@tencent.com>
> ---
>   README            |  26 ++++++
>   man/Makefile.am   |   2 +-
>   man/mount.erofs.1 | 202 ++++++++++++++++++++++++++++++++++++++++++++++
>   mount/main.c      |  41 +++++++++-
>   4 files changed, 269 insertions(+), 2 deletions(-)
>   create mode 100644 man/mount.erofs.1
> 
> diff --git a/README b/README
> index b885fa8..784bd50 100644
> --- a/README
> +++ b/README
> @@ -4,6 +4,7 @@ erofs-utils
>   Userspace tools for EROFS filesystem, currently including:
>   
>     mkfs.erofs    filesystem formatter
> +  mount.erofs   mount helper for EROFS
>     erofsfuse     FUSE daemon alternative
>     dump.erofs    filesystem analyzer
>     fsck.erofs    filesystem compatibility & consistency checker as well
> @@ -206,6 +207,31 @@ git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.git -b obsoleted
>   PLEASE NOTE: This version is highly _NOT recommended_ now.
>   
>   
> +mount.erofs
> +-----------
> +
> +mount.erofs is a mount helper for EROFS filesystem, which can be used
> +to mount EROFS images with various backends including direct kernel
> +mount, FUSE-based mount, and NBD for remote sources like OCI images.
> +
> +How to mount an EROFS image
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +To mount an EROFS image directly:
> + $ mount.erofs foo.erofs.img /mnt

$ mount.erofs foo.erofs mnt

> +
> +To mount with FUSE backend:
> + $ mount.erofs -t erofs.fuse foo.erofs.img /mnt

$ mount.erofs -t erofs.fuse foo.erofs mnt

> +
> +To mount from OCI image with NBD backend:
> + $ mount.erofs -t erofs.nbd -o oci.blob=sha256:... image:tag /mnt

$ mount.erofs -t erofs.nbd -o oci.blob=sha256:... <IMAGE>:<TAG> mnt

> +
> +To unmount:

To unmount an EROFS filesystem:

> + $ mount.erofs -u /mnt

$ mount.erofs -u mnt

> +
> +For more details, see mount.erofs(1) manpage.
> +
> +
>   erofsfuse
>   ---------
>   
> diff --git a/man/Makefile.am b/man/Makefile.am
> index 4628b85..2990e77 100644
> --- a/man/Makefile.am
> +++ b/man/Makefile.am
> @@ -1,6 +1,6 @@
>   # SPDX-License-Identifier: GPL-2.0+
>   
> -dist_man_MANS = mkfs.erofs.1 dump.erofs.1 fsck.erofs.1
> +dist_man_MANS = mkfs.erofs.1 dump.erofs.1 fsck.erofs.1 mount.erofs.1
>   
>   EXTRA_DIST = erofsfuse.1
>   if ENABLE_FUSE
> diff --git a/man/mount.erofs.1 b/man/mount.erofs.1
> new file mode 100644
> index 0000000..6eeb48c
> --- /dev/null
> +++ b/man/mount.erofs.1
> @@ -0,0 +1,202 @@
> +.\" Copyright (c) 2025 Chengyu Zhu <hudsonzhu@tencent.com>
> +.\"
> +.TH MOUNT.EROFS 1
> +.SH NAME
> +mount.erofs \- manage EROFS filesystem
> +.SH SYNOPSIS
> +\fBmount.erofs\fR [\fIOPTIONS\fR] \fISOURCE\fR \fIMOUNTPOINT\fR
> +.br
> +\fBmount.erofs\fR \fB\-u\fR \fITARGET\fR
> +.br
> +\fBmount.erofs\fR \fB\-\-reattach\fR \fITARGET\fR
> +.SH DESCRIPTION
> +EROFS is an enhanced lightweight read-only filesystem with modern designs
> +for scenarios which need high-performance read-only requirements.
> +.PP
> +\fBmount.erofs\fR is used to mount an EROFS filesystem from \fISOURCE\fR
> +(which can be an image file or block device) to a \fIMOUNTPOINT\fR. It supports multiple backends including
> +direct kernel mount, FUSE-based mount, and NBD (Network Block Device) for
> +remote sources like OCI images.
> +.SH OPTIONS
> +.TP
> +.B \-h, \-\-help
> +Display help message and exit.
> +.TP
> +.B \-V, \-\-version
> +Display version information and exit.
> +.TP
> +.BI "\-o " options
> +Comma-separated list of mount options. See \fBMOUNT OPTIONS\fR below.
> +.TP
> +.BI "\-t " type[.subtype]
> +Specify the filesystem type and optional subtype. The type should be
> +\fBerofs\fR. Available subtypes are:
> +.RS
> +.TP
> +.B fuse
> +Use FUSE-based mount via \fBerofsfuse\fR.
> +.TP
> +.B local
> +Force direct kernel mount (default if available).
> +.TP
> +.B nbd
> +Use NBD backend for remote sources (e.g., OCI images).
> +.RE
> +.TP
> +.B \-u
> +Unmount the filesystem at the specified target.
> +.TP
> +.B \-\-reattach
> +Reattach to an existing NBD device and restart the NBD service.
> +.SH MOUNT OPTIONS
> +Standard mount options:
> +.TP
> +.B ro
> +Mount the filesystem read-only (default).
> +.TP
> +.B rw
> +Mount the filesystem read-write (not supported for EROFS).
> +.TP
> +.B nosuid
> +Do not honor set-user-ID and set-group-ID bits.
> +.TP
> +.B suid
> +Honor set-user-ID and set-group-ID bits (default).
> +.TP
> +.B nodev
> +Do not interpret character or block special devices.
> +.TP
> +.B dev
> +Interpret character or block special devices (default).
> +.TP
> +.B noexec
> +Do not allow direct execution of any binaries.
> +.TP
> +.B exec
> +Allow execution of binaries (default).
> +.TP
> +.B noatime
> +Do not update inode access times.
> +.TP
> +.B atime
> +Update inode access times (default).
> +.TP
> +.B nodiratime
> +Do not update directory inode access times.
> +.TP
> +.B diratime
> +Update directory inode access times (default).
> +.TP
> +.B relatime
> +Update inode access times relative to modify or change time.
> +.TP
> +.B norelatime
> +Do not use relative atime updates.
> +.SH OCI-SPECIFIC OPTIONS
> +The following OCI-specific options are available:
> +.TP
> +.BI "oci.blob=" digest
> +Specify the OCI blob digest to mount. The digest should be in the format
> +\fBsha256:...\fR. Cannot be used together with \fBoci.layer\fR.
> +.TP
> +.BI "oci.layer=" index
> +Specify the OCI layer index to mount (0-based). Cannot be used together
> +with \fBoci.blob\fR.
> +.TP
> +.BI "oci.platform=" platform
> +Specify the target platform (default: \fBlinux/amd64\fR).
> +.TP
> +.BI "oci.username=" username
> +Username for OCI registry authentication.
> +.TP
> +.BI "oci.password=" password
> +Password for OCI registry authentication.
> +.TP
> +.BI "oci.tarindex=" path
> +Path to a tarball index file for hybrid tar+OCI mode.
> +.TP
> +.BI "oci.zinfo=" path
> +Path to a gzip zinfo file for random access to gzip-compressed tar layers.
> +.SH EXAMPLES

Maybe just drop this part "EXAMPLES" since I'm not sure it
should be in the manpage.

> +.SH NOTES
> +.IP \(bu 2
> +EROFS filesystems are read-only by nature. The \fBrw\fR option will be ignored.
> +.IP \(bu 2
> +When mounting OCI images via NBD, the mount process creates a background
> +daemon to serve the NBD device. The daemon will automatically clean up when
> +the filesystem is unmounted.
> +.IP \(bu 2
> +The \fB\-\-reattach\fR option is useful for recovering NBD mounts after a
> +system crash or when the NBD daemon was terminated unexpectedly.
> +.IP \(bu 2
> +Loop device mounting is automatically used when mounting a regular file
> +without specifying a backend type.

Kernel direct mount is used when mounting a regular file without
specifying a backend type. If file-based mounts is unsupported,
loop devices will be set up automatically.

> +.SH SEE ALSO
> +.BR mkfs.erofs (1),
> +.BR erofsfuse (1),
> +.BR dump.erofs (1),
> +.BR fsck.erofs (1),
> +.BR mount (8),
> +.BR umount (8)
> +.SH AVAILABILITY
> +\fBmount.erofs\fR is part of erofs-utils.
> diff --git a/mount/main.c b/mount/main.c
> index e25134c..4dfa1d1 100644
> --- a/mount/main.c
> +++ b/mount/main.c
> @@ -81,6 +81,38 @@ static struct erofs_nbd_source {
>   	};
>   } nbdsrc;
>   
> +static void usage(int argc, char **argv)
> +{
> +	printf("Usage: %s [OPTIONS] SOURCE [MOUNTPOINT]\n"
> +		"Manage EROFS filesystem.\n"
> +		"\n"
> +		"General options:\n"
> +		" -V, --version		print the version number of mount.erofs and exit\n"
> +		" -h, --help		display this help and exit\n"
> +		" -o options		comma-separated list of mount options\n"
> +		" -t type[.subtype]	filesystem type (and optional subtype)\n"
> +		" 			subtypes: fuse, local, nbd\n"
> +		" -u 			unmount the filesystem\n"
> +		"    --reattach		reattach to an existing NBD device\n"
> +#ifdef OCIEROFS_ENABLED
> +		"\n"
> +		"OCI-specific options (with -o):\n"
> +		"   oci.blob=<digest>   specify OCI blob digest (sha256:...)\n"
> +		"   oci.layer=<index>   specify OCI layer index (0-based)\n"

0-based sounds odd, maybe find a better representation.

Thanks,
Gao Xiang

