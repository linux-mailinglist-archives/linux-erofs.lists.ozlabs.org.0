Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id CAC678688C0
	for <lists+linux-erofs@lfdr.de>; Tue, 27 Feb 2024 06:43:52 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=hcT0sITq;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4TkRHV3sz6z3cVv
	for <lists+linux-erofs@lfdr.de>; Tue, 27 Feb 2024 16:43:50 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=hcT0sITq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4TkRHK3rssz3bX5
	for <linux-erofs@lists.ozlabs.org>; Tue, 27 Feb 2024 16:43:39 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1709012613; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=duF83pFjpLWXQqBW71BVZ5OvzJk2CbkKkby0y69tRvg=;
	b=hcT0sITqepU5mJtLyfoDLX4bPJY9h3TZDw+HJz1zZuxRNi6YULre2SDgJgDoWrOtOdwy6C+uILZ7tgmul9dJ4BJnd6/v6rZLF8vwXPS01yIlIuAFSL4cjNkflyaVyR9nDV3ayg8wAurvSDggxHKXdKQcLzCbAhrIYTOPBVB5kvY=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R431e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0W1Lec.0_1709012611;
Received: from 30.97.48.177(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W1Lec.0_1709012611)
          by smtp.aliyun-inc.com;
          Tue, 27 Feb 2024 13:43:32 +0800
Message-ID: <20359e03-f7aa-4531-b0d1-b76e9950f233@linux.alibaba.com>
Date: Tue, 27 Feb 2024 13:43:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs-utils: mkfs: Support tar source without data
To: Mike Baynton <mike@mbaynton.com>, linux-erofs@lists.ozlabs.org
References: <20240227051154.4009326-1-mike@mbaynton.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240227051154.4009326-1-mike@mbaynton.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

Hi Mike!

On 2024/2/27 13:11, Mike Baynton wrote:
> This improves performance of meta-only image creation in cases where the
> source is a tarball stream that is not seekable. The writer may now use
> --tar=headerball and omit the file data. Previously, the stream writer was
> forced to send the file's size worth of null bytes or any data after each
> tar header which was simply discarded by mkfs.erofs.
> 
> Signed-off-by: Mike Baynton <mike@mbaynton.com>
> ---
> Sorry for the delay getting to this, it fulfills a feature request
> discussed a week or so ago:
> <https://lore.kernel.org/linux-erofs/5db6f727-00e1-4625-9914-3ffabfc8c43f@linux.alibaba.com>
> It sounded like we wanted the new option to be more verbose than just
> `h`, and I thought "headerball" hinted at what it is more than "header",
> but happy to change it if that's too weird!

I guess `headerball` is derived from `tarball`, yet I wonder
the meaning of `-ball` :-)

I'm happy with the new naming, and will try this patch later!

Thanks,
Gao Xiang

> 
> Thank you for your careful review, it's a simple change but this was
> motivated by necessity and isn't really my wheelhouse.
> 
>   include/erofs/tar.h |  2 +-
>   lib/tar.c           |  2 +-
>   man/mkfs.erofs.1    | 23 +++++++++++++++++------
>   mkfs/main.c         |  9 ++++++---
>   4 files changed, 25 insertions(+), 11 deletions(-)
> 
> diff --git a/include/erofs/tar.h b/include/erofs/tar.h
> index a76f740..3d40a0f 100644
> --- a/include/erofs/tar.h
> +++ b/include/erofs/tar.h
> @@ -46,7 +46,7 @@ struct erofs_tarfile {
>   
>   	int fd;
>   	u64 offset;
> -	bool index_mode, aufs;
> +	bool index_mode, headeronly_mode, aufs;
>   };
>   
>   void erofs_iostream_close(struct erofs_iostream *ios);
> diff --git a/lib/tar.c b/lib/tar.c
> index 8204939..e916395 100644
> --- a/lib/tar.c
> +++ b/lib/tar.c
> @@ -584,7 +584,7 @@ static int tarerofs_write_file_index(struct erofs_inode *inode,
>   	ret = tarerofs_write_chunkes(inode, data_offset);
>   	if (ret)
>   		return ret;
> -	if (erofs_iostream_lskip(&tar->ios, inode->i_size))
> +	if (!tar->headeronly_mode && erofs_iostream_lskip(&tar->ios, inode->i_size))
>   		return -EIO;
>   	return 0;
>   }
> diff --git a/man/mkfs.erofs.1 b/man/mkfs.erofs.1
> index 00ac2ac..d488983 100644
> --- a/man/mkfs.erofs.1
> +++ b/man/mkfs.erofs.1
> @@ -17,7 +17,7 @@ achieve high performance for embedded devices with limited memory since it has
>   unnoticable memory overhead and page cache thrashing.
>   .PP
>   mkfs.erofs is used to create such EROFS filesystem \fIDESTINATION\fR image file
> -from \fISOURCE\fR directory.
> +from \fISOURCE\fR directory or tarball.
>   .SH OPTIONS
>   .TP
>   .BI "\-z " compression-algorithm \fR[\fP, # \fR][\fP: ... \fR]\fP
> @@ -180,11 +180,22 @@ Use extended inodes instead of compact inodes if the file modification time
>   would overflow compact inodes. This is the default. Overrides
>   .BR --ignore-mtime .
>   .TP
> -.B "\-\-tar=f"
> -Generate a full EROFS image from a tarball.
> -.TP
> -.B "\-\-tar=i"
> -Generate an meta-only EROFS image from a tarball.
> +.BI "\-\-tar, \-\-tar="MODE
> +Treat \fISOURCE\fR as a tarball or tarball-like "headerball" rather than as a
> +directory.
> +
> +\fIMODE\fR may be one of \fBf\fR, \fBi\fR, or \fBheaderball\fR.
> +
> +\fBf\fR: Generate a full EROFS image from a regular tarball. (default)
> +
> +\fBi\fR: Generate a meta-only EROFS image from a regular tarball. Only
> +metadata such as dentries, inodes, and xattrs will be added to the image,
> +without file data. Uses for such images include as a layer in an overlay
> +filesystem with other data-only layers.
> +
> +\fBheaderball\fR: Generate a meta-only EROFS image from a stream identical
> +to a tarball except that file data is not present after each file header.
> +Can improve performance especially when \fISOURCE\fR is not seekable.
>   .TP
>   .BI "\-\-uid-offset=" UIDOFFSET
>   Add \fIUIDOFFSET\fR to all file UIDs.
> diff --git a/mkfs/main.c b/mkfs/main.c
> index 6d2b700..36e248a 100644
> --- a/mkfs/main.c
> +++ b/mkfs/main.c
> @@ -122,7 +122,8 @@ static void usage(void)
>   	      " --max-extent-bytes=#  set maximum decompressed extent size # in bytes\n"
>   	      " --preserve-mtime      keep per-file modification time strictly\n"
>   	      " --aufs                replace aufs special files with overlayfs metadata\n"
> -	      " --tar=[fi]            generate an image from tarball(s)\n"
> +	      " --tar=[X]             generate a full or index-only image from a tarball(-ish) source\n"
> +	      "                       X=f|i|headerball; f=full, i=index, headerball=tar w/o file data\n"
>   	      " --ovlfs-strip=[01]    strip overlayfs metadata in the target image (e.g. whiteouts)\n"
>   	      " --quiet               quiet execution (do not write anything to standard output.)\n"
>   #ifndef NDEBUG
> @@ -514,11 +515,13 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
>   			cfg.c_extra_ea_name_prefixes = true;
>   			break;
>   		case 20:
> -			if (optarg && (!strcmp(optarg, "i") ||
> -				!strcmp(optarg, "0") || !memcmp(optarg, "0,", 2))) {
> +			if (optarg && (!strcmp(optarg, "i") || (!strcmp(optarg, "headerball") ||
> +				!strcmp(optarg, "0") || !memcmp(optarg, "0,", 2)))) {
>   				erofstar.index_mode = true;
>   				if (!memcmp(optarg, "0,", 2))
>   					erofstar.mapfile = strdup(optarg + 2);
> +				if (!strcmp(optarg, "headerball"))
> +					erofstar.headeronly_mode = true;
>   			}
>   			tar_mode = true;
>   			break;
