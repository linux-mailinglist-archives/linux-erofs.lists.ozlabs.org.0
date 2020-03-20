Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id D1DBF18CC87
	for <lists+linux-erofs@lfdr.de>; Fri, 20 Mar 2020 12:17:15 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48kLpJ75QrzDrS2
	for <lists+linux-erofs@lfdr.de>; Fri, 20 Mar 2020 22:17:12 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1584703033;
	bh=xI9JOlIkvqphrHO0tsL+Oeusi+Ms5zmidRXuYkrWQZY=;
	h=Date:To:Subject:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=F3RRMBnp/H0Vi32oV5rdLGVAOM3fqPBr2ck1H48qZHPurjz1LXnDKEKToYdqxsoBD
	 NAFS8wqHqjYAu+tsH9CuKxuz2vdehE9EAV12RNPAbnST2wCJScw+okXy5fD+s94Yc1
	 yvZC9UBBaoYSrDS7vGFOOUXwxYHd808hhI+LBz8txKshJpQZbnBox62ivf0La/FWJn
	 ibRov6bjwtENxwrUSTUxDkLTPte0m1neKiZ1bCSiah8i/GynOPYO2/gas4AGsKf8/A
	 SY37XBQ2MIS9IMrUG9hNVbYFkqt8GxUPf3ocj5mDpgBGZu7srQSxTCNug1iL03Ipl1
	 yp9LGTG/a3QkA==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=66.163.189.82; helo=sonic306-20.consmr.mail.ne1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.a=rsa-sha256
 header.s=a2048 header.b=oAHfaqzd; dkim-atps=neutral
Received: from sonic306-20.consmr.mail.ne1.yahoo.com
 (sonic306-20.consmr.mail.ne1.yahoo.com [66.163.189.82])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48kLp32xt0zDrRC
 for <linux-erofs@lists.ozlabs.org>; Fri, 20 Mar 2020 22:16:57 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1584703013; bh=GgRqSlR8p3ZIc3duRogOha8GLvrwIP6DKJ9rs3iGdRc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Subject;
 b=oAHfaqzdn6g/8bGRktAW9U0n4gLkcdvIURGX1D4hbb9Qk+BezKci0fd4Duu38rXxpbMF1i/uxvK3ZpewYqLxvn+BLUuBZ3u8EmZZb9AgafamUU3rbbQNyoXmuqp6MGz21kazmf+qDvWTsVI+rK4Y7hVfJw3dXDGEe3vNT9jlLx5gGtti8txzSLeQNqQRDH88D2cyEI7t2H73RuiKUPUciC56Bh3+8D7pC92WmuGn5l7n18AoHo3Jd3QQ5uIE/ucGeGbqFLExoAqTNtfAnJQnvahGqZFVjqns8OesIV/Gar3xD6YKkbRS+0a1mjk3d4AitWbm5+n2gVU8E7PLI4w0OA==
X-YMail-OSG: c_.v5F8VM1kXvQBV.CYVRB9.tS_gT1WG6isyceFAr8SVJHtmyxJ4lU4NeMfDmQi
 qNH.5z9gEe7scNE5sAbhl4OJm8SCwN5eemH.ndIBWmeUvAOTQXuBr_6aJeDoe5P4BRwetIzz3Fg8
 FfWBLKiuzyixRuvHvzL.naPBamGuhuDfEWn7bGQ9NF6IE.5iW2zGNAClcuTiCoadZfg_lbaienHg
 6zxuApikk2O_v6KHNhLIiTNqxbF7RD9kPMtrGNnzw0j0_cPOPec.0wS2btITgvakarUx_pZBCG1u
 G_AXFQQ5eeqcPNmB.nP6x764.7By7dXuWrgUXzqoYy_ANn6Aqdc1fx2eaVFHPo9RXtifM8_7qd4d
 d0C4.tmGXuLXz2nlD.nX6RiQch7TU4Pgj6_VXbv5Vzwo9HLhTF7j_XN8Q7riA7.bwUVv1cArUzzh
 r5c8HCj13Fst1Ngx2M3zS0Z8ze9viYBvv0cyTznkplng79brnHjIkMGxYiQ46D1xwdNoQWKXkNsz
 FhbjiI_yiRsjfRzqO1JLyc2Pt17xyxgxjcb9IguxULaBi7oNJaAUcmDQtxyes6phOcXm.KguIBmr
 BWpHcYrVkDgQrY_H_8lbE9Gmcx28mPbfdpHPeaIUZk4lSrwgOFKQQiESqRIDUKmH583UWyozkvIZ
 fFScqgt4RCedyzQksdVKrTzJGQ2nKZcu4c9IJEshLTZHdkm3XLfEda_m1tSl9EzUGDN3ADj4.uq3
 dmYE_5pM5VlziE5W6JqAArf48MFCm1SKpdA1qEOiB2ejzYRGl8n_2DgeqapQuaIdecE44c5W4BPi
 3tjCR8Yc6UhjOq6uBTStf4eGOUdejfu8ueV1etdhw7sfMZUbfrZf90jBEFdXB_7deinSWV19Bj4Z
 ozIxV24pxTNLeNwNs6q8YYRs2YCfJLbzaRpIszXYEmhIWLZ9TR7fBjAYFe73WHwLuWfxR9odggNY
 .TrWxznKnn9n71_f8vyqqtQkyuCAg1foowEOKYGLYrP1zWFB453W8b.GY3G_AX1a.iVPoNc618ah
 qwg5p0.hwFq6XHMm8jldQq8fJusCTqA32uu.91CYxhc0X9HTPR.w5kRAKGq4x3nrxB7ZUOLiRWzc
 Eo1aI0ylChIrxXajxsKgLYDkwmO0EPDREep_b2Of7WAXnSa0IMN8Hj3WoX6YHqWa8wtcW.vk7ClY
 8k8ffciK.N6gNLv_XRPy_65Ir4Ih7Nr8n74GAoRI_4Pjw.icFcmqOrnRYjHumfTFLXwGZUUIybkY
 NPLmMYGNCY4mqTQOz8PDn.FBFZ9kiQ_kjLI_4U1eDLF_8QgigX_GNkoKbRkLYK.qy7VVRDR4BiPK
 LbGJ8mgap58s2rCoSvdeAMeGPi5Or.vuWElG0wNezAHagE4egV3D8P3FBAjNulpRcLcqKF_r95vM
 MN_Do
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic306.consmr.mail.ne1.yahoo.com with HTTP; Fri, 20 Mar 2020 11:16:53 +0000
Received: by smtp413.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA
 ID 19e0db855f7413596b0d48e05aeb0339; 
 Fri, 20 Mar 2020 11:16:47 +0000 (UTC)
Date: Fri, 20 Mar 2020 19:16:36 +0800
To: Saumya Panda <saumya.iisc@gmail.com>
Subject: Re: Problem in EROFS: Not able to read the files after mount
Message-ID: <20200320111625.GA1794@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <CAHmfoRm7xUwuXfTZ2kr-x9fs59x7b707t183ggbLEtEyO_wznA@mail.gmail.com>
 <20200120073859.GA32421@hsiangkao-HP-ZHAN-66-Pro-G1>
 <CAHmfoRn+YjEwxmZLTeDVN9Oja=7QTi14oEtpD5x7URT_X9dJ5w@mail.gmail.com>
 <20200122043655.GB6542@hsiangkao-HP-ZHAN-66-Pro-G1>
 <CAHmfoRmXxEXqxJwakbQZmMz62_7DNai3KVzGu=U_yNEgYQvG=w@mail.gmail.com>
 <20200129045942.GB7472@hsiangkao-HP-ZHAN-66-Pro-G1>
 <CAHmfoRm8mfUdup7yPotvG7HEc21sCB3TB6FvMZhoV_zevxUdsQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHmfoRm8mfUdup7yPotvG7HEc21sCB3TB6FvMZhoV_zevxUdsQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Mailer: WebService/1.1.15471 hermes Apache-HttpAsyncClient/4.1.4
 (Java/1.8.0_241)
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
From: Gao Xiang via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Gao Xiang <hsiangkao@aol.com>
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Saumya,

On Fri, Mar 20, 2020 at 01:30:39PM +0530, Saumya Panda wrote:
> Hi Gao,
>   I am trying to evaluate Erofs on my device. Right now SquashFS is used
> for system files. Hence I am trying to compare Erofs with SquashFs. On my
> device with the below environment I am seeing Erofs is 3 times faster than
> SquashFS 128k (I used enwik8 (100MB) as testing file)) while doing Seq
> Read. Your test result shows it is near to SquasFs 128k. How Erofs is so
> fast for Seq Read?  I also tested  it on Suse VM with low memory(free
> memory 425MB) and I am seeing Erofs is pretty fast.
> 
> Also Can you tell me how to run FIO on directory instead of files ?
>  fio -filename=$i -rw=read -bs=4k -name=seqbench

Thanks for your detailed words.

Firstly, I cannot think out some way to run FIO on directory directly.
And maybe some numbers below are still strange in my opinion.

OK, Actually, I don't want to leave a lot of (maybe aggressive) comments
publicly to compare one filesystem with other filesystems, such as EROFS
vs squashfs (or ext4 vs f2fs). But there are actually some exist materials
which did this before, if you have some extra time, you could read through
the following reference materials about EROFS (although some parts are outdated):

[1] https://static.sched.com/hosted_files/kccncosschn19chi/ce/EROFS%20file%20system_OSS2019_Final.pdf
[2] https://www.usenix.org/system/files/atc19-gao.pdf

The reason why I think in this way is that (Objectively, I think) people
have their own judgement / insistance on every stuffs. But okay, there are
some hints why EROFS behaves well in this email (compared with Squashfs, but
I really want to avoid such aggressive topics):

 o EROFS has carefully designed critial paths, such as async decompression
   path. that partly answers your question about sequential read behavior;

 o EROFS has well-designed compression metadata (called EROFS compacted
   index). Each logic compressed block only takes 2-byte metadata on average
   (high information entropy, so no need to compress compacted indexes again)
   and it supports random read without pervious meta dependence. In contrast,
   the on-disk metadata of Squashfs doesn't support random read (and even
   metadata itself could be compressed), which means you have to cached more
   metadata in memory for random read, or you'll stand with its bad metadata
   random access performance. some hint: see ondisk blocklist, index cache
   and read_blocklist();

 o EROFS firstly uses fixed-sized output compression in filesystem field.
   By using fixed-sized output compression, EROFS can easily implement
   in-place decompression (or at least in-place I/O), which means that it
   doesn't allocate physical pages for most cases, therefore fewer memory
   reclaim/compaction possibility and keeps useful file-backed page cache
   as much as possible;

 o EROFS has designed on-disk directory format, it supports directory
   random access compared with current Squashfs;

In a word, I don't think the current on-disk squashfs is a well-designed
stuff in the long term. In other words, EROFS is a completely different
stuff either from its principle, the on-disk format  and runtime
implementation...)

By the way, the pervious link
https://blog.csdn.net/scnutiger/article/details/102507596
was _not_ written by me. I just noticed it by chance, I think
it was written by some Chinese kernel developer from some other
Android vendor.

And FIO cannot benchmark all cases, heavy memory workload
doesn't completely equal to low memory as well.

However, there is my FIO test script to benchmark different fses:

https://github.com/erofs/erofs-openbenchmark/blob/master/fio-benchmark.sh

for reference. Personally, I think it's reasonable.

It makes more sense to use designed dynamic model. Huawei interally uses
several well-designed light/heavy workloads to benchmark the whole system.

In addition, I noticed many complaints about Squashfs, e.g:

https://forum.snapcraft.io/t/squashfs-is-a-terrible-storage-format/9466

I don't want to comment the whole content itself. But for such runtime
workloads, I'd suggest using EROFS instead and see if it performs better
(compared with any configuration of squashfs+lz4).

There are many ongoing stuffs to do, but I'm really busy recently. After
implementing LZMA and larger compress cluster, I think EROFS will be more
useful, but it needs to be carefully designed first in order to avoid
further complexity of the whole solution. 

Sorry about my English, hope it of some help..

Thanks,
Gao Xiang


> 
>              Test on Embedded Device:
> 
> Total Memory 5.5 GB:
> 
>  Free Memory 1515
> 
>  No Swap
> 
> 
> $: /fio/erofs_test]$ free -m
> 
>               total        used        free      shared  buff/cache
> available
> 
> Mem:           5384        2315        1515        1378        1553
> 1592
> 
> Swap:             0           0           0
> 
> 
> 
> 
> 
> Seq Read
> 
> 
> 
> Rand Read
> 
> 
> 
> 
> 
> squashFS 4k
> 
> 
> 
> 51.8MB/s
> 
> 1931msec
> 
> 45.7MB/s
> 
> 2187msec
> 
> 
> 
> SquashFS 128k
> 
> 
> 
> 116MB/s
> 
> 861msec
> 
> 14MB/s
> 
> 877msec
> 
> 
> 
> SquashFS 1M
> 
> 
> 
> 124MB/s-124MB/s
> 
> 805msec
> 
> 119MB/s
> 
> 837msec
> 
> 
> 
> 
> 
> Erofs 4k
> 
> 
> 
> 658MB/s-658MB/s
> 
> 152msec
> 
> 
> 
> 103MB
> 
> 974msec
> 
> 
> 
> 
> 
> 
> 
>  Test on Suse VM:
> 
> 
> Total Memory 1.5 GB:
> 
>  Free Memory 425
> 
>  No Swap
> 
> localhost:/home/saumya/Documents/erofs_test # free -m
>               total        used        free      shared  buff/cache
> available
> Mem:           1436         817         425           5         192
> 444
> Swap:             0           0           0
> 
> 
> 
> 
> 
> 
> Seq Read
> 
> 
> 
> Rand Read
> 
> 
> 
> 
> 
> squashFS 4k
> 
> 
> 
> 30.7MB/s
> 
> 3216msec
> 
> 9333kB/s
> 
> 10715msec
> 
> 
> 
> SquashFS 128k
> 
> 
> 
> 318MB/s
> 
> 314msec
> 
> 5946kB/s
> 
> 16819msec
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> Erofs 4k
> 
> 
> 
> 469MB/s
> 
> 213msec
> 
> 
> 
> 11.9MB/s
> 
> 8414msec
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> On Wed, Jan 29, 2020 at 10:30 AM Gao Xiang <hsiangkao@aol.com> wrote:
> 
> > On Wed, Jan 29, 2020 at 09:43:37AM +0530, Saumya Panda wrote:
> > >
> > > localhost:~> fio --name=randread --ioengine=libaio --iodepth=16
> > > --rw=randread --bs=4k --direct=0 --size=512M --numjobs=4 --runtime=240
> > > --group_reporting --filename=/mnt/enwik9_erofs/enwik9
> > >
> > > randread: (g=0): rw=randread, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T)
> > > 4096B-4096B, ioengine=libaio, iodepth=16
> >
> > And I don't think such configuration is useful to calculate read
> > ampfication
> > since you read 100% finally, use multi-thread without memory limitation
> > (all
> > compressed data will be cached, so the total read is compressed size).
> >
> > I have no idea what you want to get via doing comparsion between EROFS and
> > Squashfs. Larger block size much like readahead in bulk. If you benchmark
> > uncompressed file systems, you will notice such filesystems cannot get such
> > high 100% randread number.
> >
> > Thank,
> > Gao Xiang
> >
> >
> 
> -- 
> Thanks,
> Saumya Prakash Panda
