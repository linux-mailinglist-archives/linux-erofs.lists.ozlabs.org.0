Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id E45946DBFE4
	for <lists+linux-erofs@lfdr.de>; Sun,  9 Apr 2023 14:47:08 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PvX1Q66WNz3cf0
	for <lists+linux-erofs@lfdr.de>; Sun,  9 Apr 2023 22:47:06 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PvX1H2Sgsz3cd5
	for <linux-erofs@lists.ozlabs.org>; Sun,  9 Apr 2023 22:46:58 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0Vfd4dJY_1681044411;
Received: from 30.213.177.139(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Vfd4dJY_1681044411)
          by smtp.aliyun-inc.com;
          Sun, 09 Apr 2023 20:46:53 +0800
Message-ID: <ebdbbead-54ad-1ae1-b358-16ed79190376@linux.alibaba.com>
Date: Sun, 9 Apr 2023 20:46:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: [PATCH 3/5] erofs-utils: man: mkfs.erofs: wording/formatting
 touchups
To: =?UTF-8?Q?Ahelenia_Ziemia=c5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>
References: <d80484200b3ba60127ff3b92e0c7660a2e8726bf.1681041325.git.nabijaczleweli@nabijaczleweli.xyz>
 <8490d5f3cbfdd11ee2690b3e642f7cd70ac9f582.1681041325.git.nabijaczleweli@nabijaczleweli.xyz>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <8490d5f3cbfdd11ee2690b3e642f7cd70ac9f582.1681041325.git.nabijaczleweli@nabijaczleweli.xyz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
Cc: linux-erofs mailing list <linux-erofs@lists.ozlabs.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2023/4/9 19:56, Ahelenia Ziemiańska wrote:
> Some things that gave me pause or were weirdly formatted.
> 
> Signed-off-by: Ahelenia Ziemiańska <nabijaczleweli@nabijaczleweli.xyz>

Thanks, it looks much better than the current status.

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang

> ---
>   man/mkfs.erofs.1 | 100 +++++++++++++++++++++++++++--------------------
>   1 file changed, 57 insertions(+), 43 deletions(-)
> 
> diff --git a/man/mkfs.erofs.1 b/man/mkfs.erofs.1
> index 82ef138..1cfde28 100644
> --- a/man/mkfs.erofs.1
> +++ b/man/mkfs.erofs.1
> @@ -20,25 +20,25 @@ mkfs.erofs is used to create such EROFS filesystem \fIDESTINATION\fR image file
>   from \fISOURCE\fR directory.
>   .SH OPTIONS
>   .TP
> -.BI "\-z " compression-algorithm " [" ",#" "]" " [:" " ... " "]"
> +.BI "\-z " compression-algorithm \fR[\fP, # \fR][\fP: ... \fR]\fP
>   Set a primary algorithm for data compression, which can be set with an optional
>   compression level (1 to 12 for LZ4HC, 0 to 9 for LZMA and 100 to 109 for LZMA
>   extreme compression) separated by a comma.  Alternative algorithms could be
>   specified and separated by colons.
>   .TP
>   .BI "\-C " max-pcluster-size
> -Specify the maximum size of compress physical cluster in bytes. It may enable
> -big pcluster feature if needed (Linux v5.13+).
> +Specify the maximum size of compress physical cluster in bytes.
> +This may cause the big pcluster feature to be enabled (Linux v5.13+).
>   .TP
>   .BI "\-d " #
>   Specify the level of debugging messages. The default is 2, which shows basic
>   warning messages.
>   .TP
>   .BI "\-x " #
> -Specify the upper limit of an xattr which is still inlined. The default is 2.
> -Disable storing xattrs if < 0.
> +Limit how many xattrs will be inlined. The default is 2.
> +Disables storing xattrs if < 0.
>   .TP
> -.BI "\-E " extended-option " [,...]"
> +.BI "\-E " extended-option \fR[\fP, ... \fR]\fP
>   Set extended options for the filesystem. Extended options are comma separated,
>   and may take an extra argument using the equals ('=') sign.
>   The following extended options are supported:
> @@ -51,29 +51,30 @@ it may take an argument as the pcluster size of the packed inode in bytes.
>   .TP
>   .BI dedupe
>   Enable global compressed data deduplication to minimize duplicated data in
> -the filesystem. It may be used with \fI-Efragments\fR option together to
> -further reduce image sizes. (Linux v6.1+)
> +the filesystem. May further reduce image size when used with
> +.BR -E\ fragments .
> +(Linux v6.1+)
>   .TP
>   .BI force-inode-compact
> -Forcely generate compact inodes (32-byte inodes) to output.
> +Force generation of compact (32-byte) inodes.
>   .TP
>   .BI force-inode-extended
> -Forcely generate extended inodes (64-byte inodes) to output.
> +Force generation of extended (64-byte) inodes.
>   .TP
>   .BI force-inode-blockmap
> -Forcely generate inode chunk format in 4-byte block address array.
> +Force generation of inode chunk format as a 4-byte block address array.
>   .TP
>   .BI force-chunk-indexes
> -Forcely generate inode chunk format in 8-byte chunk indexes (with device id).
> +Forcely generate inode chunk format as an 8-byte chunk index (with device ID).
>   .TP
> -.BI fragments
> -Pack the tail part (pcluster) of compressed files or the whole files into a
> +.BI fragments\fR[\fP= size \fR]\fP
> +Pack the tail part (pcluster) of compressed files, or entire files, into a
>   special inode for smaller image sizes, and it may take an argument as the
>   pcluster size of the packed inode in bytes. (Linux v6.1+)
>   .TP
>   .BI legacy-compress
> -Drop "inplace decompression" and "compacted indexes" support, which is used
> -to generate compatible EROFS images for Linux v4.19 - 5.3.
> +Disable "inplace decompression" and "compacted indexes",
> +for compatibility with Linux pre-v5.4.
>   .TP
>   .BI noinline_data
>   Don't inline regular files to enable FSDAX for these files (Linux v5.15+).
> @@ -89,8 +90,8 @@ Set the volume label for the filesystem to
>   The maximum length of the volume label is 16 bytes.
>   .TP
>   .BI "\-T " #
> -Set all files to the given UNIX timestamp. Reproducible builds requires setting
> -all to a specific one.
> +Set all files to the given UNIX timestamp. Reproducible builds require setting
> +all to a specific one. By default, the source file's modification time is used.
>   .TP
>   .BI "\-U " UUID
>   Set the universally unique identifier (UUID) of the filesystem to
> @@ -102,64 +103,77 @@ like this: "c1b9d5a2-f162-11cf-9ece-0020afc76f16".
>   Make all files owned by root.
>   .TP
>   .BI "\-\-blobdev " file
> -Specify another extra blob device to store chunk-based data.
> +Specify an extra blob device to store chunk-based data.
>   .TP
>   .BI "\-\-chunksize " #
>   Generate chunk-based files with #-byte chunks.
>   .TP
>   .BI "\-\-compress-hints " file
> -If the optional
> -.BI "\-\-compress-hints " file
> -argument is given,
> -.B mkfs.erofs
> -uses it to apply the per-file compression strategy. Each line is defined by
> +Apply a per-file compression strategy. Each line in
> +.I file
> +is defined by
>   tokens separated by spaces in the following form.  Optionally, instead of
> -the given primary algorithm, alternative algorithms could be specified with
> -\fIalgorithm-index\fR by hand:
> +the given primary algorithm, alternative algorithms can be specified with
> +\fIalgorithm-index\fR explicitly:
>   .RS 1.2i
> -<pcluster-in-bytes> [algorithm-index] <match-pattern>
> +<pcluster-size-in-bytes> [algorithm-index] <match-pattern>
>   .RE
> +.IR match-pattern s
> +are extended regular expressions, matched against absolute paths within
> +the output filesystem, with no leading /.
>   .TP
>   .BI "\-\-exclude-path=" path
>   Ignore file that matches the exact literal path.
> -You may give multiple `--exclude-path' options.
> +You may give multiple
> +.B --exclude-path
> +options.
>   .TP
>   .BI "\-\-exclude-regex=" regex
> -Ignore files that match the given regular expression.
> -You may give multiple `--exclude-regex` options.
> +Ignore files that match the given extended regular expression.
> +You may give multiple
> +.B --exclude-regex
> +options.
>   .TP
>   .BI "\-\-file-contexts=" file
> -Specify a \fIfile_contexts\fR file to setup / override selinux labels.
> +Read SELinux label configuration/overrides from \fIfile\fR in the
> +.BR selinux_file (5)
> +format.
>   .TP
>   .BI "\-\-force-uid=" UID
> -Set all file uids to \fIUID\fR.
> +Set all file UIDs to \fIUID\fR.
>   .TP
>   .BI "\-\-force-gid=" GID
> -Set all file gids to \fIGID\fR.
> +Set all file GIDs to \fIGID\fR.
>   .TP
>   .BI "\-\-gid-offset=" GIDOFFSET
> -Add \fIGIDOFFSET\fR to all file gids.
> -When this option is used together with --force-gid, the final file gids are
> +Add \fIGIDOFFSET\fR to all file GIDs.
> +When this option is used together with
> +.BR --force-gid ,
> +the final file gids are
>   set to \fIGID\fR + \fIGID-OFFSET\fR.
>   .TP
>   .B \-\-help
> -Display this help and exit.
> +Display help string and exit.
>   .TP
>   .B "\-\-ignore-mtime"
> -File modification time is ignored whenever it would cause \fBmkfs.erofs\fR to
> +Ignore the file modification time whenever it would cause \fBmkfs.erofs\fR to
>   use extended inodes over compact inodes. When not using a fixed timestamp, this
> -can reduce total metadata size.
> +can reduce total metadata size. Implied by
> +.BR "-E force-inode-compact" .
>   .TP
>   .BI "\-\-max-extent-bytes " #
> -Specify maximum decompressed extent size # in bytes.
> +Specify maximum decompressed extent size in bytes.
>   .TP
>   .B "\-\-preserve-mtime"
> -File modification time is preserved whenever \fBmkfs.erofs\fR decides to use
> -extended inodes over compact inodes.
> +Use extended inodes instead of compact inodes if the file modification time
> +would overflow compact inodes. This is the default. Overrides
> +.BR --ignore-mtime .
>   .TP
>   .BI "\-\-uid-offset=" UIDOFFSET
> -Add \fIUIDOFFSET\fR to all file uids.
> -When this option is used together with --force-uid, the final file uids are
> +Add \fIUIDOFFSET\fR to all file UIDs.
> +When this option is used together with
> +.BR --force-uid ,
> +the final file uids are
>   set to \fIUID\fR + \fIUIDOFFSET\fR.
>   .SH AUTHOR
>   This version of \fBmkfs.erofs\fR is written by Li Guifu <blucerlee@gmail.com>,
