Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE865859D4D
	for <lists+linux-erofs@lfdr.de>; Mon, 19 Feb 2024 08:46:57 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=PtcprTIq;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4TdZPC3nx6z3cBx
	for <lists+linux-erofs@lfdr.de>; Mon, 19 Feb 2024 18:46:55 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=PtcprTIq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4TdZP53C9zz3bWn
	for <linux-erofs@lists.ozlabs.org>; Mon, 19 Feb 2024 18:46:46 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1708328801; h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type;
	bh=7o3AdvOyXoiNM3bb0JFrz1J838ILM0NtowxWGl/Uexk=;
	b=PtcprTIqZtiXyHBItJIJWmmH2+/223DY/wfn+Eq6GWk4fgmytxtVgYK/ZxGYUMRxnTJ+6WvQvzyd158P2OYZUm5y8JMWdLBjbOd6QTZKDx97R69wh+wikKmG33Z2O9HDkIHK1uDpGVy6PmmxcCZwPJWE+4wlrMj6qjTQPDtj1Ig=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R581e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0W0palJd_1708328799;
Received: from 30.97.48.192(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W0palJd_1708328799)
          by smtp.aliyun-inc.com;
          Mon, 19 Feb 2024 15:46:40 +0800
Message-ID: <c33281cb-6af8-419d-87b2-af7717e7f509@linux.alibaba.com>
Date: Mon, 19 Feb 2024 15:46:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Feature request: erofs-utils mkfs: Efficient way to pipe only
 file metadata
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Mike Baynton <mike@mbaynton.com>, linux-erofs@lists.ozlabs.org
References: <CAM56kJTupW_WZapYM6YzFLPtriYb5+FU-Y8-mYY8ETGYfQmG6g@mail.gmail.com>
 <5d558d53-a1d8-4bfc-b2a3-a10cd941d786@linux.alibaba.com>
In-Reply-To: <5d558d53-a1d8-4bfc-b2a3-a10cd941d786@linux.alibaba.com>
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2024/2/19 12:44, Gao Xiang wrote:
> Hi Mike,
> 
> On 2024/2/19 11:37, Mike Baynton wrote:
>> Hello erofs developers,
>> I am integrating erofs with overlayfs in a manner similar to what
>> composefs is doing. So, I am interested in making erofs images
>> containing only file metadata and extended attributes, but no file
>> data, as in $ mkfs.erofs --tar=i (thanks for that!)
> 
> Thanks for your interest in EROFS too.
> 
>>
>> However, I would like to construct the erofs image from a set of files
>> selected dynamically by another program. This leads me to prefer
>> sending an unseekable stream to mkfs.erofs so that file selection and
>> image generation can run concurrently, instead of first making a
>> complete tarball and then making the erofs image. In this case, it
>> becomes necessary to transfer each file's worth of data through the
>> stream after each header only so that the tarball reader in tar.c does
>> not become desynchronized with the expected offset of the next tar
>> header.
> 
> I wonder if it's possible to use a modified prototype-like [1] format
> which mkfs.xfs [2] currently supports with "-p".  This prototype can
> be passed with a pipe instead.
> 
> [1] http://uw714doc.sco.com/en/man/html.4/prototype.4.html
> [2] https://man7.org/linux/man-pages/man8/mkfs.xfs.8.html

.. mkfs.xfs protofile uses the following syntax originally instead:
https://man.cat-v.org/unix-6th/8/mkfs

> 
>>
>> A very straightforward solution that seems to be working just fine for
>> me is to simply introduce a new optarg for --tar that indicates the
>> input data will be simply a series of tar headers / metadata without
>> actual file data. This implies index mode and additionally prevents
>> the skipping of inode.size worth of bytes after each header:
>>
>> diff --git a/include/erofs/tar.h b/include/erofs/tar.h
>> index a76f740..3d40a0f 100644
>> --- a/include/erofs/tar.h
>> +++ b/include/erofs/tar.h
>> @@ -46,7 +46,7 @@ struct erofs_tarfile {
>>
>>    int fd;
>>    u64 offset;
>> - bool index_mode, aufs;
>> + bool index_mode, headeronly_mode, aufs;
>>   };
>>
>>   void erofs_iostream_close(struct erofs_iostream *ios);
>> diff --git a/lib/tar.c b/lib/tar.c
>> index 8204939..e916395 100644
>> --- a/lib/tar.c
>> +++ b/lib/tar.c
>> @@ -584,7 +584,7 @@ static int tarerofs_write_file_index(struct
>> erofs_inode *inode,
>>    ret = tarerofs_write_chunkes(inode, data_offset);
>>    if (ret)
>>    return ret;
>> - if (erofs_iostream_lskip(&tar->ios, inode->i_size))
>> + if (!tar->headeronly_mode && erofs_iostream_lskip(&tar->ios, inode->i_size))
>>    return -EIO;
>>    return 0;
>>   }
>> diff --git a/mkfs/main.c b/mkfs/main.c
>> index 6d2b700..a72d30e 100644
>> --- a/mkfs/main.c
>> +++ b/mkfs/main.c
>> @@ -122,7 +122,7 @@ static void usage(void)
>>          " --max-extent-bytes=#  set maximum decompressed extent size #
>> in bytes\n"
>>          " --preserve-mtime      keep per-file modification time strictly\n"
>>          " --aufs                replace aufs special files with
>> overlayfs metadata\n"
>> -       " --tar=[fi]            generate an image from tarball(s)\n"
>> +       " --tar=[fih]           generate an image from tarball(s) or
>> tarball header data\n"
>>          " --ovlfs-strip=[01]    strip overlayfs metadata in the target
>> image (e.g. whiteouts)\n"
>>          " --quiet               quiet execution (do not write anything
>> to standard output.)\n"
>>   #ifndef NDEBUG
>> @@ -514,11 +514,13 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
>>    cfg.c_extra_ea_name_prefixes = true;
>>    break;
>>    case 20:
>> - if (optarg && (!strcmp(optarg, "i") ||
>> - !strcmp(optarg, "0") || !memcmp(optarg, "0,", 2))) {
>> + if (optarg && (!strcmp(optarg, "i") || (!strcmp(optarg, "h") ||
>> + !strcmp(optarg, "0") || !memcmp(optarg, "0,", 2)))) {
>>    erofstar.index_mode = true;
>>    if (!memcmp(optarg, "0,", 2))
>>    erofstar.mapfile = strdup(optarg + 2);
>> + if (!strcmp(optarg, "h"))
>> + erofstar.headeronly_mode = true;
>>    }
>>    tar_mode = true;
>>    break;
>>
>> Using this requires generation of tarball-ish streams that can be
>> slightly difficult to cajole tar libraries into creating, but it does
>> work if you do it. I can imagine much more complex alternative ways to
>> do this too, such as supporting sparse tar files or supporting some
>> whole new input format.
> 
> I think you could just fill zero to use the current index mode now.
> But yes, it could be inefficient if some files are huge.
> 
>>
>> Would some version of this feature be interesting and useful? If so,
>> is the simple way good enough? It wouldn't preclude future addition of
>> things like a sparse tar reader.
> 
> Yes, I think it's useful to support a simple prototype-like format, but
> it might take time on my own since there are some other ongoing stuffs
> to be landed (like multi-threading mkfs support.)
> 
> Thanks,
> Gao Xiang
> 
>>
>> Regards,
>> Mike
