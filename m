Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BD9A34C30B
	for <lists+linux-erofs@lfdr.de>; Mon, 29 Mar 2021 07:37:24 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4F81YZ01dDz301P
	for <lists+linux-erofs@lfdr.de>; Mon, 29 Mar 2021 16:37:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ghcqOQ93;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ghcqOQ93;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=216.205.24.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=hsiangkao@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=ghcqOQ93; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=ghcqOQ93; 
 dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4F81YW0FzSz2ysm
 for <linux-erofs@lists.ozlabs.org>; Mon, 29 Mar 2021 16:37:17 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1616996232;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NXKJhRg4VrR3/hGIT05ghl1NvcsDN4yPI1Z+tXmjmAA=;
 b=ghcqOQ93yRPx+4hHlEsyWJ3oF4Vbzb5FapgaKJQj+Jw5BjPj1p5f+pcJTXupjS2+Kdqf+t
 nELZzY2fmNipDJ3ie6y35WwACwsXzrOI7vYOSJ7jDKW7NRw/vD8dMctB5flf99Piw9n9Ar
 5O1IbhM0SvR1KyCUKWjjNpbR++4eSZE=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1616996232;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NXKJhRg4VrR3/hGIT05ghl1NvcsDN4yPI1Z+tXmjmAA=;
 b=ghcqOQ93yRPx+4hHlEsyWJ3oF4Vbzb5FapgaKJQj+Jw5BjPj1p5f+pcJTXupjS2+Kdqf+t
 nELZzY2fmNipDJ3ie6y35WwACwsXzrOI7vYOSJ7jDKW7NRw/vD8dMctB5flf99Piw9n9Ar
 5O1IbhM0SvR1KyCUKWjjNpbR++4eSZE=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-73-khOTHysBM4292uKNMx38mw-1; Mon, 29 Mar 2021 01:37:09 -0400
X-MC-Unique: khOTHysBM4292uKNMx38mw-1
Received: by mail-pl1-f200.google.com with SMTP id a16so4969126plm.17
 for <linux-erofs@lists.ozlabs.org>; Sun, 28 Mar 2021 22:37:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=NXKJhRg4VrR3/hGIT05ghl1NvcsDN4yPI1Z+tXmjmAA=;
 b=ER+5sopWrrbvSjj84rDWTAC3XO++4+BbYOvNRlIfS9fSm2ZZ34+sOsbQLvIckKqMBp
 71OfL3BhBz/kXYjFd+/qcT/h4tJrxVOcli4oLmMQd8Pu5VdVSzMCggu1z/xKqQVE8JM+
 ODJSr79kjzO9OTep7ghcVRbgKAr0KzZ8/+AzWzGZLtHYKv1tfKxMkb43nJUd6v8MpjmC
 TcVq1B7jQnPkK3sgz1gCFPjBwCneGckIuQSTxcO8A6nqvhBERkuoPOGfSJBlGnt+JjB5
 Gm3SiY/4Trz0sv3rrsbVo978UBUiNvkqaPE0UM0yKGxgBtIwkwFCcxgOH3pPcsfGLgjZ
 Si8Q==
X-Gm-Message-State: AOAM532iwSU0GedgjsSGXcDOPnF2PjnDA7XNLUX75HWckNUUD+oQAQq9
 Afd67SRBKTL6axAs1Z5XvSlpTPLmUipBxc/lAR3Lh76J63GFyijvLpg+VjWGmUGE6J+dKvxzEGy
 ObjieVySCNBG/0g6WinOC3Y4+V0EbTlaEJ2v4x33S5Ix6/Frf7RjlqE4rYH7cINl14zHWIehhAA
 lV0Q==
X-Received: by 2002:a62:1581:0:b029:202:7800:442 with SMTP id
 123-20020a6215810000b029020278000442mr24068820pfv.3.1616996227543; 
 Sun, 28 Mar 2021 22:37:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx85qhcstCaqiH/mW6sVvuAmD3P8CKPxZYXFmsJA8Jz5d4PIMlcfNy3EEA46S10Hzmp2KTDFg==
X-Received: by 2002:a62:1581:0:b029:202:7800:442 with SMTP id
 123-20020a6215810000b029020278000442mr24068783pfv.3.1616996226946; 
 Sun, 28 Mar 2021 22:37:06 -0700 (PDT)
Received: from xiangao.remote.csb ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id w15sm15662560pfn.84.2021.03.28.22.37.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Mar 2021 22:37:06 -0700 (PDT)
Date: Mon, 29 Mar 2021 13:36:54 +0800
From: Gao Xiang <hsiangkao@redhat.com>
To: linux-erofs@lists.ozlabs.org
Subject: EROFS big pcluster feature benchmark
Message-ID: <20210329053654.GA3281654@xiangao.remote.csb>
References: <20210227185027.GA13741.ref@hsiangkao-HP-ZHAN-66-Pro-G1>
 <20210227185027.GA13741@hsiangkao-HP-ZHAN-66-Pro-G1>
MIME-Version: 1.0
In-Reply-To: <20210227185027.GA13741@hsiangkao-HP-ZHAN-66-Pro-G1>
User-Agent: Mutt/1.10.1 (2018-07-13)
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=hsiangkao@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
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
Cc: nl6720 <nl6720@gmail.com>, Lasse Collin <lasse.collin@tukaani.org>,
 LKML <linux-kernel@vger.kernel.org>, Guo Weichao <guoweichao@oppo.com>,
 Miao Xie <miaoxie@huawei.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi folks,

The following shows the latest progress of EROFS big pcluster feature
for the upcoming 5.13, note that big pcluster also enables inplace
decompression to minimize extra page allocation and cache thrashing.

Kernel: Linux 5.10-rc5
Testsuite: erofs-openbenchmark
Testdata: enwik9 (1000000000 bytes)
Compression algorithm: lz4hc, 9

Processor: Intel(R) Core(TM) i5-8250U CPU @ 1.60GHz
SSD: INTEL SSDPEKKF360G7H (360 GB)
DDR: Samsung M471A1K43CB1-CRC (8 GB)
OS Distribution: Debian 10
Test environment:
Turbo Boost disabled
scaling_governor = userspace, scaling_{min,max}_freq = 1801000

Squashfs configuration:
CONFIG_SQUASHFS_FILE_DIRECT=y
CONFIG_SQUASHFS_DECOMP_MULTI_PERCPU=y

EROFS git repos:
https://git.kernel.org/pub/scm/linux/kernel/git/xiang/linux.git -b erofs/bigpcluster
https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.git -b experimental-bigpcluster-compact

Note that test data should vary on different CPU/storage combinations.
The principle to boost up seq read is that many (not all) storage
devices perform lower I/O latency with smaller I/O size, so increase
pcluster size would increase C/R thus I/O size would be smaller.

 ________________________________________________________________
|  file system  |   size    | seq read | rand read | rand9m read |
|_______________|___________|_ MiB/s __|__ MiB/s __|___ MiB/s ___|
|___erofs_4k____|_556879872_|_ 781.4 __|__ 55.3 ___|___ 25.3  ___|
|___erofs_16k___|_452509696_|_ 864.8 __|_ 123.2 ___|___ 20.8  ___|
|___erofs_32k___|_415223808_|_ 899.8 __|_ 105.8 _*_|___ 16.8 ____|
|___erofs_64k___|_393814016_|_ 906.6 __|__ 66.6 _*_|___ 11.8 ____|
|__squashfs_8k__|_556191744_|_  64.9 __|__ 19.3 ___|____ 9.1 ____|
|__squashfs_16k_|_502661120_|_  98.9 __|__ 38.0 ___|____ 9.8 ____|
|__squashfs_32k_|_458784768_|_ 115.4 __|__ 71.6 _*_|___ 10.0 ____|
|_squashfs_128k_|_398204928_|_ 257.2 __|_ 253.8 _*_|___ 10.9 ____|
|____ext4_4k____|____()_____|_ 786.6 __|__ 28.6 ___|___ 27.8 ____|


* Squashfs grabs more page cache to keep all decompressed data with
  grab_cache_page_nowait() than the normal requested readahead (see
  squashfs_copy_cache and squashfs_readpage_block).
  In principle, EROFS can also cache such all decompressed data
  if necessary, yet it's low priority for now and have little use
  (rand9m is actually a better rand read workload, since the amount
   of I/O is 9m rather than full-sized 1000m).

For the comparison of other filesystems, see:
https://github.com/erofs/erofs-openbenchmark/wiki

Thanks,
Gao Xiang

RAW DATA:
benchmarking imgs/enwik9_4k.erofs.compacted.img with erofs
mntdir/enwik9
[seqread]
   READ: bw=832MiB/s (873MB/s), 832MiB/s-832MiB/s (873MB/s-873MB/s), io=954MiB (1000MB), run=1146-1146msec
   READ: bw=780MiB/s (818MB/s), 780MiB/s-780MiB/s (818MB/s-818MB/s), io=954MiB (1000MB), run=1222-1222msec
   READ: bw=771MiB/s (808MB/s), 771MiB/s-771MiB/s (808MB/s-808MB/s), io=954MiB (1000MB), run=1237-1237msec
   READ: bw=761MiB/s (797MB/s), 761MiB/s-761MiB/s (797MB/s-797MB/s), io=954MiB (1000MB), run=1254-1254msec
   READ: bw=763MiB/s (800MB/s), 763MiB/s-763MiB/s (800MB/s-800MB/s), io=954MiB (1000MB), run=1250-1250msec
[randread]
   READ: bw=56.1MiB/s (58.8MB/s), 56.1MiB/s-56.1MiB/s (58.8MB/s-58.8MB/s), io=954MiB (1000MB), run=16995-16995msec
   READ: bw=54.6MiB/s (57.3MB/s), 54.6MiB/s-54.6MiB/s (57.3MB/s-57.3MB/s), io=954MiB (1000MB), run=17457-17457msec
   READ: bw=54.6MiB/s (57.3MB/s), 54.6MiB/s-54.6MiB/s (57.3MB/s-57.3MB/s), io=954MiB (1000MB), run=17460-17460msec
   READ: bw=56.7MiB/s (59.5MB/s), 56.7MiB/s-56.7MiB/s (59.5MB/s-59.5MB/s), io=954MiB (1000MB), run=16811-16811msec
   READ: bw=54.6MiB/s (57.2MB/s), 54.6MiB/s-54.6MiB/s (57.2MB/s-57.2MB/s), io=954MiB (1000MB), run=17479-17479msec
[randread_9m]
   READ: bw=23.8MiB/s (24.0MB/s), 23.8MiB/s-23.8MiB/s (24.0MB/s-24.0MB/s), io=9216KiB (9437kB), run=378-378msec
   READ: bw=24.6MiB/s (25.8MB/s), 24.6MiB/s-24.6MiB/s (25.8MB/s-25.8MB/s), io=9216KiB (9437kB), run=366-366msec
   READ: bw=25.6MiB/s (26.8MB/s), 25.6MiB/s-25.6MiB/s (26.8MB/s-26.8MB/s), io=9216KiB (9437kB), run=352-352msec
   READ: bw=26.1MiB/s (27.4MB/s), 26.1MiB/s-26.1MiB/s (27.4MB/s-27.4MB/s), io=9216KiB (9437kB), run=345-345msec
   READ: bw=26.3MiB/s (27.6MB/s), 26.3MiB/s-26.3MiB/s (27.6MB/s-27.6MB/s), io=9216KiB (9437kB), run=342-342msec

benchmarking imgs/enwik9_16k.erofs.compacted.img with erofs
mntdir/enwik9
[seqread]
   READ: bw=905MiB/s (949MB/s), 905MiB/s-905MiB/s (949MB/s-949MB/s), io=954MiB (1000MB), run=1054-1054msec
   READ: bw=845MiB/s (887MB/s), 845MiB/s-845MiB/s (887MB/s-887MB/s), io=954MiB (1000MB), run=1128-1128msec
   READ: bw=860MiB/s (902MB/s), 860MiB/s-860MiB/s (902MB/s-902MB/s), io=954MiB (1000MB), run=1109-1109msec
   READ: bw=861MiB/s (903MB/s), 861MiB/s-861MiB/s (903MB/s-903MB/s), io=954MiB (1000MB), run=1107-1107msec
   READ: bw=853MiB/s (894MB/s), 853MiB/s-853MiB/s (894MB/s-894MB/s), io=954MiB (1000MB), run=1118-1118msec
[randread]
   READ: bw=126MiB/s (132MB/s), 126MiB/s-126MiB/s (132MB/s-132MB/s), io=954MiB (1000MB), run=7552-7552msec
   READ: bw=125MiB/s (131MB/s), 125MiB/s-125MiB/s (131MB/s-131MB/s), io=954MiB (1000MB), run=7626-7626msec
   READ: bw=122MiB/s (128MB/s), 122MiB/s-122MiB/s (128MB/s-128MB/s), io=954MiB (1000MB), run=7809-7809msec
   READ: bw=122MiB/s (128MB/s), 122MiB/s-122MiB/s (128MB/s-128MB/s), io=954MiB (1000MB), run=7841-7841msec
   READ: bw=121MiB/s (127MB/s), 121MiB/s-121MiB/s (127MB/s-127MB/s), io=954MiB (1000MB), run=7878-7878msec
[randread_9m]
   READ: bw=20.4MiB/s (21.4MB/s), 20.4MiB/s-20.4MiB/s (21.4MB/s-21.4MB/s), io=9216KiB (9437kB), run=441-441msec
   READ: bw=21.0MiB/s (22.0MB/s), 21.0MiB/s-21.0MiB/s (22.0MB/s-22.0MB/s), io=9216KiB (9437kB), run=428-428msec
   READ: bw=20.8MiB/s (21.8MB/s), 20.8MiB/s-20.8MiB/s (21.8MB/s-21.8MB/s), io=9216KiB (9437kB), run=432-432msec
   READ: bw=20.9MiB/s (21.9MB/s), 20.9MiB/s-20.9MiB/s (21.9MB/s-21.9MB/s), io=9216KiB (9437kB), run=431-431msec
   READ: bw=20.8MiB/s (21.8MB/s), 20.8MiB/s-20.8MiB/s (21.8MB/s-21.8MB/s), io=9216KiB (9437kB), run=433-433msec

benchmarking imgs/enwik9_32k.erofs.compacted.img with erofs
mntdir/enwik9
[seqread]
   READ: bw=925MiB/s (970MB/s), 925MiB/s-925MiB/s (970MB/s-970MB/s), io=954MiB (1000MB), run=1031-1031msec
   READ: bw=933MiB/s (978MB/s), 933MiB/s-933MiB/s (978MB/s-978MB/s), io=954MiB (1000MB), run=1022-1022msec
   READ: bw=921MiB/s (965MB/s), 921MiB/s-921MiB/s (965MB/s-965MB/s), io=954MiB (1000MB), run=1036-1036msec
   READ: bw=862MiB/s (904MB/s), 862MiB/s-862MiB/s (904MB/s-904MB/s), io=954MiB (1000MB), run=1106-1106msec
   READ: bw=858MiB/s (900MB/s), 858MiB/s-858MiB/s (900MB/s-900MB/s), io=954MiB (1000MB), run=1111-1111msec
[randread]
   READ: bw=121MiB/s (127MB/s), 121MiB/s-121MiB/s (127MB/s-127MB/s), io=954MiB (1000MB), run=7853-7853msec
   READ: bw=101MiB/s (106MB/s), 101MiB/s-101MiB/s (106MB/s-106MB/s), io=954MiB (1000MB), run=9415-9415msec
   READ: bw=103MiB/s (108MB/s), 103MiB/s-103MiB/s (108MB/s-108MB/s), io=954MiB (1000MB), run=9290-9290msec
   READ: bw=102MiB/s (107MB/s), 102MiB/s-102MiB/s (107MB/s-107MB/s), io=954MiB (1000MB), run=9312-9312msec
   READ: bw=102MiB/s (107MB/s), 102MiB/s-102MiB/s (107MB/s-107MB/s), io=954MiB (1000MB), run=9325-9325msec
[randread_9m]
   READ: bw=16.4MiB/s (17.2MB/s), 16.4MiB/s-16.4MiB/s (17.2MB/s-17.2MB/s), io=9216KiB (9437kB), run=548-548msec
   READ: bw=16.7MiB/s (17.5MB/s), 16.7MiB/s-16.7MiB/s (17.5MB/s-17.5MB/s), io=9216KiB (9437kB), run=539-539msec
   READ: bw=16.8MiB/s (17.6MB/s), 16.8MiB/s-16.8MiB/s (17.6MB/s-17.6MB/s), io=9216KiB (9437kB), run=537-537msec
   READ: bw=17.5MiB/s (18.4MB/s), 17.5MiB/s-17.5MiB/s (18.4MB/s-18.4MB/s), io=9216KiB (9437kB), run=513-513msec
   READ: bw=16.6MiB/s (17.4MB/s), 16.6MiB/s-16.6MiB/s (17.4MB/s-17.4MB/s), io=9216KiB (9437kB), run=543-543msec

benchmarking imgs/enwik9_64k.erofs.compacted.img with erofs
mntdir/enwik9
[seqread]
   READ: bw=963MiB/s (1010MB/s), 963MiB/s-963MiB/s (1010MB/s-1010MB/s), io=954MiB (1000MB), run=990-990msec
   READ: bw=941MiB/s (986MB/s), 941MiB/s-941MiB/s (986MB/s-986MB/s), io=954MiB (1000MB), run=1014-1014msec
   READ: bw=928MiB/s (973MB/s), 928MiB/s-928MiB/s (973MB/s-973MB/s), io=954MiB (1000MB), run=1028-1028msec
   READ: bw=857MiB/s (898MB/s), 857MiB/s-857MiB/s (898MB/s-898MB/s), io=954MiB (1000MB), run=1113-1113msec
   READ: bw=844MiB/s (885MB/s), 844MiB/s-844MiB/s (885MB/s-885MB/s), io=954MiB (1000MB), run=1130-1130msec
[randread]
   READ: bw=73.6MiB/s (77.2MB/s), 73.6MiB/s-73.6MiB/s (77.2MB/s-77.2MB/s), io=954MiB (1000MB), run=12954-12954msec
   READ: bw=65.8MiB/s (68.0MB/s), 65.8MiB/s-65.8MiB/s (68.0MB/s-68.0MB/s), io=954MiB (1000MB), run=14495-14495msec
   READ: bw=65.4MiB/s (68.6MB/s), 65.4MiB/s-65.4MiB/s (68.6MB/s-68.6MB/s), io=954MiB (1000MB), run=14576-14576msec
   READ: bw=65.0MiB/s (69.2MB/s), 65.0MiB/s-65.0MiB/s (69.2MB/s-69.2MB/s), io=954MiB (1000MB), run=14450-14450msec
   READ: bw=62.8MiB/s (65.8MB/s), 62.8MiB/s-62.8MiB/s (65.8MB/s-65.8MB/s), io=954MiB (1000MB), run=15189-15189msec
[randread_9m]
   READ: bw=12.5MiB/s (13.1MB/s), 12.5MiB/s-12.5MiB/s (13.1MB/s-13.1MB/s), io=9216KiB (9437kB), run=718-718msec
   READ: bw=12.4MiB/s (12.0MB/s), 12.4MiB/s-12.4MiB/s (12.0MB/s-12.0MB/s), io=9216KiB (9437kB), run=727-727msec
   READ: bw=12.5MiB/s (13.1MB/s), 12.5MiB/s-12.5MiB/s (13.1MB/s-13.1MB/s), io=9216KiB (9437kB), run=720-720msec
   READ: bw=10.7MiB/s (11.2MB/s), 10.7MiB/s-10.7MiB/s (11.2MB/s-11.2MB/s), io=9216KiB (9437kB), run=839-839msec
   READ: bw=11.1MiB/s (11.6MB/s), 11.1MiB/s-11.1MiB/s (11.6MB/s-11.6MB/s), io=9216KiB (9437kB), run=811-811msec


benchmarking imgs/enwik9_8k.squashfs.img with squashfs
mntdir/enwik9
[seqread]
   READ: bw=70.0MiB/s (74.4MB/s), 70.0MiB/s-70.0MiB/s (74.4MB/s-74.4MB/s), io=954MiB (1000MB), run=13439-13439msec
   READ: bw=63.0MiB/s (67.1MB/s), 63.0MiB/s-63.0MiB/s (67.1MB/s-67.1MB/s), io=954MiB (1000MB), run=14906-14906msec
   READ: bw=62.8MiB/s (65.9MB/s), 62.8MiB/s-62.8MiB/s (65.9MB/s-65.9MB/s), io=954MiB (1000MB), run=15179-15179msec
   READ: bw=64.7MiB/s (67.9MB/s), 64.7MiB/s-64.7MiB/s (67.9MB/s-67.9MB/s), io=954MiB (1000MB), run=14735-14735msec
   READ: bw=63.8MiB/s (66.9MB/s), 63.8MiB/s-63.8MiB/s (66.9MB/s-66.9MB/s), io=954MiB (1000MB), run=14957-14957msec
[randread]
   READ: bw=18.8MiB/s (19.7MB/s), 18.8MiB/s-18.8MiB/s (19.7MB/s-19.7MB/s), io=954MiB (1000MB), run=50859-50859msec
   READ: bw=20.3MiB/s (21.3MB/s), 20.3MiB/s-20.3MiB/s (21.3MB/s-21.3MB/s), io=954MiB (1000MB), run=46996-46996msec
   READ: bw=20.5MiB/s (21.5MB/s), 20.5MiB/s-20.5MiB/s (21.5MB/s-21.5MB/s), io=954MiB (1000MB), run=46615-46615msec
   READ: bw=18.6MiB/s (19.5MB/s), 18.6MiB/s-18.6MiB/s (19.5MB/s-19.5MB/s), io=954MiB (1000MB), run=51277-51277msec
   READ: bw=18.3MiB/s (19.1MB/s), 18.3MiB/s-18.3MiB/s (19.1MB/s-19.1MB/s), io=954MiB (1000MB), run=52234-52234msec
[randread_9m]
   READ: bw=9000KiB/s (9216kB/s), 9000KiB/s-9000KiB/s (9216kB/s-9216kB/s), io=9216KiB (9437kB), run=1024-1024msec
   READ: bw=9207KiB/s (9428kB/s), 9207KiB/s-9207KiB/s (9428kB/s-9428kB/s), io=9216KiB (9437kB), run=1001-1001msec
   READ: bw=9888KiB/s (10.1MB/s), 9888KiB/s-9888KiB/s (10.1MB/s-10.1MB/s), io=9216KiB (9437kB), run=932-932msec
   READ: bw=9347KiB/s (9571kB/s), 9347KiB/s-9347KiB/s (9571kB/s-9571kB/s), io=9216KiB (9437kB), run=986-986msec
   READ: bw=8948KiB/s (9162kB/s), 8948KiB/s-8948KiB/s (9162kB/s-9162kB/s), io=9216KiB (9437kB), run=1030-1030msec

benchmarking imgs/enwik9_16k.squashfs.img with squashfs
mntdir/enwik9
[seqread]
   READ: bw=103MiB/s (108MB/s), 103MiB/s-103MiB/s (108MB/s-108MB/s), io=954MiB (1000MB), run=9296-9296msec
   READ: bw=98.4MiB/s (103MB/s), 98.4MiB/s-98.4MiB/s (103MB/s-103MB/s), io=954MiB (1000MB), run=9691-9691msec
   READ: bw=101MiB/s (106MB/s), 101MiB/s-101MiB/s (106MB/s-106MB/s), io=954MiB (1000MB), run=9430-9430msec
   READ: bw=93.1MiB/s (97.6MB/s), 93.1MiB/s-93.1MiB/s (97.6MB/s-97.6MB/s), io=954MiB (1000MB), run=10244-10244msec
   READ: bw=98.9MiB/s (104MB/s), 98.9MiB/s-98.9MiB/s (104MB/s-104MB/s), io=954MiB (1000MB), run=9641-9641msec
[randread]
   READ: bw=36.1MiB/s (37.9MB/s), 36.1MiB/s-36.1MiB/s (37.9MB/s-37.9MB/s), io=954MiB (1000MB), run=26402-26402msec
   READ: bw=39.1MiB/s (41.0MB/s), 39.1MiB/s-39.1MiB/s (41.0MB/s-41.0MB/s), io=954MiB (1000MB), run=24374-24374msec
   READ: bw=37.0MiB/s (38.8MB/s), 37.0MiB/s-37.0MiB/s (38.8MB/s-38.8MB/s), io=954MiB (1000MB), run=25740-25740msec
   READ: bw=36.5MiB/s (38.3MB/s), 36.5MiB/s-36.5MiB/s (38.3MB/s-38.3MB/s), io=954MiB (1000MB), run=26122-26122msec
   READ: bw=41.4MiB/s (43.4MB/s), 41.4MiB/s-41.4MiB/s (43.4MB/s-43.4MB/s), io=954MiB (1000MB), run=23062-23062msec
[randread_9m]
   READ: bw=9.93MiB/s (10.4MB/s), 9.93MiB/s-9.93MiB/s (10.4MB/s-10.4MB/s), io=9216KiB (9437kB), run=906-906msec
   READ: bw=9773KiB/s (10.0MB/s), 9773KiB/s-9773KiB/s (10.0MB/s-10.0MB/s), io=9216KiB (9437kB), run=943-943msec
   READ: bw=9671KiB/s (9903kB/s), 9671KiB/s-9671KiB/s (9903kB/s-9903kB/s), io=9216KiB (9437kB), run=953-953msec
   READ: bw=9.89MiB/s (10.4MB/s), 9.89MiB/s-9.89MiB/s (10.4MB/s-10.4MB/s), io=9216KiB (9437kB), run=910-910msec
   READ: bw=10.0MiB/s (10.5MB/s), 10.0MiB/s-10.0MiB/s (10.5MB/s-10.5MB/s), io=9216KiB (9437kB), run=900-900msec

benchmarking imgs/enwik9_32k.squashfs.img with squashfs
mntdir/enwik9
[seqread]
   READ: bw=121MiB/s (126MB/s), 121MiB/s-121MiB/s (126MB/s-126MB/s), io=954MiB (1000MB), run=7908-7908msec
   READ: bw=116MiB/s (121MB/s), 116MiB/s-116MiB/s (121MB/s-121MB/s), io=954MiB (1000MB), run=8239-8239msec
   READ: bw=117MiB/s (123MB/s), 117MiB/s-117MiB/s (123MB/s-123MB/s), io=954MiB (1000MB), run=8161-8161msec
   READ: bw=117MiB/s (123MB/s), 117MiB/s-117MiB/s (123MB/s-123MB/s), io=954MiB (1000MB), run=8125-8125msec
   READ: bw=106MiB/s (111MB/s), 106MiB/s-106MiB/s (111MB/s-111MB/s), io=954MiB (1000MB), run=9019-9019msec
[randread]
   READ: bw=69.5MiB/s (72.8MB/s), 69.5MiB/s-69.5MiB/s (72.8MB/s-72.8MB/s), io=954MiB (1000MB), run=13730-13730msec
   READ: bw=69.2MiB/s (72.5MB/s), 69.2MiB/s-69.2MiB/s (72.5MB/s-72.5MB/s), io=954MiB (1000MB), run=13791-13791msec
   READ: bw=68.4MiB/s (71.8MB/s), 68.4MiB/s-68.4MiB/s (71.8MB/s-71.8MB/s), io=954MiB (1000MB), run=13937-13937msec
   READ: bw=82.1MiB/s (86.1MB/s), 82.1MiB/s-82.1MiB/s (86.1MB/s-86.1MB/s), io=954MiB (1000MB), run=11616-11616msec
   READ: bw=68.5MiB/s (71.8MB/s), 68.5MiB/s-68.5MiB/s (71.8MB/s-71.8MB/s), io=954MiB (1000MB), run=13931-13931msec
[randread_9m]
   READ: bw=9.81MiB/s (10.3MB/s), 9.81MiB/s-9.81MiB/s (10.3MB/s-10.3MB/s), io=9216KiB (9437kB), run=917-917msec
   READ: bw=10.8MiB/s (11.3MB/s), 10.8MiB/s-10.8MiB/s (11.3MB/s-11.3MB/s), io=9216KiB (9437kB), run=833-833msec
   READ: bw=9423KiB/s (9649kB/s), 9423KiB/s-9423KiB/s (9649kB/s-9649kB/s), io=9216KiB (9437kB), run=978-978msec
   READ: bw=9366KiB/s (9591kB/s), 9366KiB/s-9366KiB/s (9591kB/s-9591kB/s), io=9216KiB (9437kB), run=984-984msec
   READ: bw=11.1MiB/s (11.6MB/s), 11.1MiB/s-11.1MiB/s (11.6MB/s-11.6MB/s), io=9216KiB (9437kB), run=814-814msec

benchmarking imgs/enwik9_128k.squashfs.img with squashfs
[seqread]
   READ: bw=250MiB/s (262MB/s), 250MiB/s-250MiB/s (262MB/s-262MB/s), io=954MiB (1000MB), run=3812-3812msec
   READ: bw=269MiB/s (282MB/s), 269MiB/s-269MiB/s (282MB/s-282MB/s), io=954MiB (1000MB), run=3550-3550msec
   READ: bw=249MiB/s (261MB/s), 249MiB/s-249MiB/s (261MB/s-261MB/s), io=954MiB (1000MB), run=3833-3833msec
   READ: bw=264MiB/s (277MB/s), 264MiB/s-264MiB/s (277MB/s-277MB/s), io=954MiB (1000MB), run=3608-3608msec
   READ: bw=254MiB/s (267MB/s), 254MiB/s-254MiB/s (267MB/s-267MB/s), io=954MiB (1000MB), run=3748-3748msec
[randread]
   READ: bw=255MiB/s (268MB/s), 255MiB/s-255MiB/s (268MB/s-268MB/s), io=954MiB (1000MB), run=3736-3736msec
   READ: bw=252MiB/s (265MB/s), 252MiB/s-252MiB/s (265MB/s-265MB/s), io=954MiB (1000MB), run=3779-3779msec
   READ: bw=263MiB/s (275MB/s), 263MiB/s-263MiB/s (275MB/s-275MB/s), io=954MiB (1000MB), run=3632-3632msec
   READ: bw=253MiB/s (266MB/s), 253MiB/s-253MiB/s (266MB/s-266MB/s), io=954MiB (1000MB), run=3764-3764msec
   READ: bw=246MiB/s (258MB/s), 246MiB/s-246MiB/s (258MB/s-258MB/s), io=954MiB (1000MB), run=3880-3880msec
[randread_9m]
   READ: bw=10.8MiB/s (11.3MB/s), 10.8MiB/s-10.8MiB/s (11.3MB/s-11.3MB/s), io=9216KiB (9437kB), run=832-832msec
   READ: bw=11.2MiB/s (11.7MB/s), 11.2MiB/s-11.2MiB/s (11.7MB/s-11.7MB/s), io=9216KiB (9437kB), run=804-804msec
   READ: bw=10.0MiB/s (11.5MB/s), 10.0MiB/s-10.0MiB/s (11.5MB/s-11.5MB/s), io=9216KiB (9437kB), run=820-820msec
   READ: bw=10.6MiB/s (11.1MB/s), 10.6MiB/s-10.6MiB/s (11.1MB/s-11.1MB/s), io=9216KiB (9437kB), run=853-853msec
   READ: bw=11.8MiB/s (12.4MB/s), 11.8MiB/s-11.8MiB/s (12.4MB/s-12.4MB/s), io=9216KiB (9437kB), run=760-760msec


benchmarking imgs/enwik9_4k.ext4.img with ext4
mntdir/enwik9
[seqread]
   READ: bw=738MiB/s (773MB/s), 738MiB/s-738MiB/s (773MB/s-773MB/s), io=954MiB (1000MB), run=1293-1293msec
   READ: bw=814MiB/s (853MB/s), 814MiB/s-814MiB/s (853MB/s-853MB/s), io=954MiB (1000MB), run=1172-1172msec
   READ: bw=842MiB/s (883MB/s), 842MiB/s-842MiB/s (883MB/s-883MB/s), io=954MiB (1000MB), run=1133-1133msec
   READ: bw=721MiB/s (756MB/s), 721MiB/s-721MiB/s (756MB/s-756MB/s), io=954MiB (1000MB), run=1323-1323msec
   READ: bw=818MiB/s (858MB/s), 818MiB/s-818MiB/s (858MB/s-858MB/s), io=954MiB (1000MB), run=1166-1166msec
[randread]
   READ: bw=29.1MiB/s (30.5MB/s), 29.1MiB/s-29.1MiB/s (30.5MB/s-30.5MB/s), io=954MiB (1000MB), run=32757-32757msec
   READ: bw=29.1MiB/s (30.5MB/s), 29.1MiB/s-29.1MiB/s (30.5MB/s-30.5MB/s), io=954MiB (1000MB), run=32817-32817msec
   READ: bw=28.2MiB/s (29.6MB/s), 28.2MiB/s-28.2MiB/s (29.6MB/s-29.6MB/s), io=954MiB (1000MB), run=33768-33768msec
   READ: bw=27.3MiB/s (28.6MB/s), 27.3MiB/s-27.3MiB/s (28.6MB/s-28.6MB/s), io=954MiB (1000MB), run=34963-34963msec
   READ: bw=29.5MiB/s (30.9MB/s), 29.5MiB/s-29.5MiB/s (30.9MB/s-30.9MB/s), io=954MiB (1000MB), run=32341-32341msec
[randread_9m]
   READ: bw=31.7MiB/s (33.2MB/s), 31.7MiB/s-31.7MiB/s (33.2MB/s-33.2MB/s), io=9216KiB (9437kB), run=284-284msec
   READ: bw=25.9MiB/s (27.1MB/s), 25.9MiB/s-25.9MiB/s (27.1MB/s-27.1MB/s), io=9216KiB (9437kB), run=348-348msec
   READ: bw=30.0MiB/s (31.5MB/s), 30.0MiB/s-30.0MiB/s (31.5MB/s-31.5MB/s), io=9216KiB (9437kB), run=300-300msec
   READ: bw=27.0MiB/s (29.3MB/s), 27.0MiB/s-27.0MiB/s (29.3MB/s-29.3MB/s), io=9216KiB (9437kB), run=322-322msec
   READ: bw=24.4MiB/s (25.6MB/s), 24.4MiB/s-24.4MiB/s (25.6MB/s-25.6MB/s), io=9216KiB (9437kB), run=369-369msec

