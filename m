Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 6582214C55E
	for <lists+linux-erofs@lfdr.de>; Wed, 29 Jan 2020 05:51:18 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 486rfW2bTdzDqNk
	for <lists+linux-erofs@lfdr.de>; Wed, 29 Jan 2020 15:51:15 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1580273475;
	bh=mwesZEtHpkEdExWOza/SGpZg4leW0kVStarabvY3sI0=;
	h=Date:To:Subject:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=cVsOsYZMLdWqeBDy447nl5wwp/fbDcomxgHKyeCUH2J9S6Ly4GuvxBcRHUgPVFdUS
	 Am1172e3gbZ8Ysh9lBaxKzv1lYGIlLOgMxeaUxzeMsNnF+ovvIfOLottoZsLxweFgq
	 SgKaerSuKnuNgo/pazRqENHeqat2Yo7mwCvckctP1fdgdWIqVDkokIBTiEV0a+k7Z9
	 YUPmoMe0MQoNt8QFpQs9qGrnaXaaY/MBcc6uxBkTZH+CvIn6EqlFJcmsMFUpSv3wgV
	 lJOiwQTju2R8GPf/Qj4uZQoYTUvdYjg6Ucj4NZNhQAtmlDDKLzPHntnXUZUDQ6ibXM
	 NnaKlCL0O8/dQ==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.64.204; helo=sonic303-23.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.a=rsa-sha256
 header.s=a2048 header.b=jnxdZYZ8; dkim-atps=neutral
Received: from sonic303-23.consmr.mail.gq1.yahoo.com
 (sonic303-23.consmr.mail.gq1.yahoo.com [98.137.64.204])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 486rfJ3GcxzDqN8
 for <linux-erofs@lists.ozlabs.org>; Wed, 29 Jan 2020 15:51:01 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1580273458; bh=fl4gH6/QLhPzX3Q5EIEIfMHpva9zCsb97sTXf4LcUKQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Subject;
 b=jnxdZYZ8NsBF/eIPHg6MuJYY+XQkJr+KSUVfDDXJZM6DoCPVdkszSjlpr6OeK+KhBnO81SDG8jC2BVe8qwT0JtRi60NJu72EBud5vA1xoGfmlvtg/kkNAFEGJ9JwI1dT9F1huas4DJsfCis3kcpBHMUbagiA3ILuu3FOXNPW51/8H4N041oTaM8tFw1PD/owbpWls06OtJacQvNrL1FpKdtGJqzK7vUR7ARWjHiE6J0APb4JbuWM5hP/1tVO3F9RR5dtjGh2fVAo4bt8EwI28W7ysh4sLDr2GS9zfcA0X4hm2hiftR7n7zUop0iZWgP//ykP3A5gsxneAIRCWcenYg==
X-YMail-OSG: pEu_X0QVM1n.Xpco5kbQyUgW4aCiYuP09oSqPmZJSjPMrWkZohCcr1K2PFDV2am
 u5AwvJ39hYCy8x_TQ8OFSK2zcfQsSj9C14bG.TaHme.MeeewOnpgxLbo53HrCCD3n.dqLJpUzHzi
 nq.pnjw4YXPc_x29_u2RsLm8i0YwVOZSEE6C7YDrrPGZfSf8.DippAWdfSkGu49QwXaIzF3EyKyG
 KLM_V3v08zzAZb.j00EYOCBVPBgMOR8EpYwQYJktuiSctBZFPJNDuHWAjVNh574F8qz5CFsctccY
 ZVdNhBmslh56ZTEAGFl88p5JCY3rAksINEYbPZ2J9aaN3j1HUxAX93uT3Mg6AQjM8Zwu.iK6uLdm
 itiAOOrFUG0WdRLsIHHOc.YcuPIjS3fJgEPmE4XMqkf1EHvN4Zv7PiiFIz.IyMAZOXQa9DP_pVJi
 j65wkQoO2BDqYL2khxsDP14smpwbzYl7nrTt00_8_YlLYyHPRHw89LQ.O0p0Xe6eaake7WMflXen
 BbYmL3qViHtBWdRJV.BDvbVZKwZrkabO3U2sjxA6G2ePBIPDUs2qz2IG6YJf9icgewYTfGNfgbFf
 X2Avk0OG.MJD5L6Ka280qbtVIZjEj6EQknPWtbuvXOn.2YUX31MX2HoCqc7BctOIc7opzIhWp6n7
 vr_hRPC.3NT2o5e5P2.WtVkDKWK77fjitmu5Zl7Qlw5Xo7xrl.3vHBc2Dt7Kz567jsZYWYjEv9CT
 dkpM4YLlZ6aIwqfgpBi4k75m10X_a30PSLWm3NOyhE3.Sfd2d9XnzS.MQ6MGDcJGTTX861nJ1GXh
 upk1FcZThMGgFoaBUM8SXrd9JH5WvsLHRFXVX.WE3RYSxZH0gmB377ZUIMniemPzrfY8DCtJX9UJ
 ShfnvxQav7I0K_aJNlsKiBHZU8GmTuVuuP_gtgtfH2MB_.FDHXbTE3HKh2t.A_EBtcinFa7w0hED
 hcUkonaBQibAR9A86jY2nsBgC3IYh3m3TU46_91TRh6ZLIf5rYMvhVbSrQJ0SR9F4oVMSJdYxSTX
 RzI9GvYqsZuq66hfPrK4oe7X6YB8yIo_M7PU9xAp3VEMS3sm0.sZQBzNVfrKPYFEu8n.E5t9Ps1A
 a2XPE8H.Hf5_ROSXgTEbBm0xD_TCowF1HPes7kQNShreANrCRF5S9APhMl2YDTeX59Lclr76eIeD
 8LVHQYTb3cuVHVHdEOFx1HxS0Tqyk7OLmI199xk06Zs7UnRW1HYKdJ4g0aiPisGmFUpHezljFvxb
 aOSX.7Xtt6dJKxPcZGjTza1zVvMWyeb3S4leI_UOZyWRFINpWxFhlj5EbKZ5RU5W43fAlMK23Go7
 _q9OtelW2_RqOgoGkk8AAcEfUHUe7f.lXUUmLhdWrTn__n7FEGZbOA6LSuqRXiZZGO5xxFhp1lp.
 cMuR3IZKRWzUegSRCnNkBLb4ig3ivGjNn8I6dFeM-
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic303.consmr.mail.gq1.yahoo.com with HTTP; Wed, 29 Jan 2020 04:50:58 +0000
Received: by smtp423.mail.ir2.yahoo.com (Oath Hermes SMTP Server) with ESMTPA
 ID 285e5118c4c6a280ea4584b53a92edc4; 
 Wed, 29 Jan 2020 04:50:52 +0000 (UTC)
Date: Wed, 29 Jan 2020 12:50:43 +0800
To: Saumya Panda <saumya.iisc@gmail.com>
Subject: Re: Problem in EROFS: Not able to read the files after mount
Message-ID: <20200129045036.GA7472@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <CAHmfoRm7xUwuXfTZ2kr-x9fs59x7b707t183ggbLEtEyO_wznA@mail.gmail.com>
 <20200120073859.GA32421@hsiangkao-HP-ZHAN-66-Pro-G1>
 <CAHmfoRn+YjEwxmZLTeDVN9Oja=7QTi14oEtpD5x7URT_X9dJ5w@mail.gmail.com>
 <20200122043655.GB6542@hsiangkao-HP-ZHAN-66-Pro-G1>
 <CAHmfoRmXxEXqxJwakbQZmMz62_7DNai3KVzGu=U_yNEgYQvG=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHmfoRmXxEXqxJwakbQZmMz62_7DNai3KVzGu=U_yNEgYQvG=w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Mailer: WebService/1.1.15116 hermes Apache-HttpAsyncClient/4.1.4
 (Java/1.8.0_181)
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

On Wed, Jan 29, 2020 at 09:43:37AM +0530, Saumya Panda wrote:
> Hi Gao,
>   How you got the read amplification? I ran FIO on enwik9 (both Erofs and
> SquashFs) and got the below output. Is there anyway to calculate the read
> amplification from the below logs.

No. FIO doesn't provide such number as far as I know, you'd get all statistic
number by some block device information.

BTW, I'd suggest you umount, drop_caches, mount the filesystem every time
in order to get rid of filesystem itself internal cache and bdev buffer
cache. It would not be useful in real scenarios except for benchmark use
only.

https://github.com/erofs/erofs-openbenchmark/

Thanks,
Gao Xiang

> 
>      Here filename (/mnt/enwik9_erofs/enwik9, /mnt/enwiki_sqfs/enwik9)
> points to the mounted readonly file system(squasfs, erofs). But if I give
> directory as a parameter instead of filename I am getting error(see the
> logs at the end).
> 
> *FIO on Erofs:*
> 
> localhost:~> fio --name=randread --ioengine=libaio --iodepth=16
> --rw=randread --bs=4k --direct=0 --size=512M --numjobs=4 --runtime=240
> --group_reporting --filename=/mnt/enwik9_erofs/enwik9
> 
> randread: (g=0): rw=randread, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T)
> 4096B-4096B, ioengine=libaio, iodepth=16
> 
> ...
> 
> fio-3.17-90-gd9b7
> 
> Starting 4 processes
> 
> Jobs: 4 (f=4): [r(4)][100.0%][r=381MiB/s][r=97.6k IOPS][eta 00m:00s]
> 
> randread: (groupid=0, jobs=4): err= 0: pid=34282: Mon Jan 27 01:04:55 2020
> 
>   read: IOPS=36.7k, BW=144MiB/s (150MB/s)(2048MiB/14271msec)
> 
>     slat (nsec): min=1305, max=135688k, avg=106650.48, stdev=493480.73
> 
>     clat (nsec): min=1970, max=136593k, avg=1629459.90, stdev=2639786.83
> 
>      lat (usec): min=3, max=136625, avg=1736.29, stdev=2772.32
> 
>     clat percentiles (usec):
> 
>      |  1.00th=[    48],  5.00th=[    69], 10.00th=[   251], 20.00th=[
> 437],
> 
>      | 30.00th=[   570], 40.00th=[   701], 50.00th=[   848], 60.00th=[
> 1029],
> 
>      | 70.00th=[  1336], 80.00th=[  2147], 90.00th=[  4015], 95.00th=[
> 5932],
> 
>      | 99.00th=[ 11600], 99.50th=[ 13304], 99.90th=[ 17171], 99.95th=[
> 20579],
> 
>      | 99.99th=[135267]
> 
>    bw (  KiB/s): min=16510, max=295435, per=76.91%, avg=113025.79,
> stdev=23830.42, samples=112
> 
>    iops        : min= 4126, max=73857, avg=28254.82, stdev=5957.62,
> samples=112
> 
>   lat (usec)   : 2=0.01%, 4=0.01%, 10=0.01%, 20=0.01%, 50=1.37%
> 
>   lat (usec)   : 100=5.45%, 250=3.15%, 500=14.74%, 750=18.99%, 1000=14.99%
> 
>   lat (msec)   : 2=20.14%, 4=11.09%, 10=8.42%, 20=1.62%, 50=0.04%
> 
>   lat (msec)   : 250=0.01%
> 
>   cpu          : usr=1.87%, sys=8.28%, ctx=144023, majf=1, minf=114
> 
>   IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=100.0%, 32=0.0%,
> >=64=0.0%
> 
>      submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%,
> >=64=0.0%
> 
>      complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.1%, 32=0.0%, 64=0.0%,
> >=64=0.0%
> 
>      issued rwts: total=524288,0,0,0 short=0,0,0,0 dropped=0,0,0,0
> 
>      latency   : target=0, window=0, percentile=100.00%, depth=16
> 
> 
> 
> Run status group 0 (all jobs):
> 
>    READ: bw=144MiB/s (150MB/s), 144MiB/s-144MiB/s (150MB/s-150MB/s),
> io=2048MiB (2147MB), run=14271-14271msec
> 
> 
> 
> Disk stats (read/write):
> 
>   loop0: ios=137357/0, merge=0/0, ticks=23020/0, in_queue=460, util=97.70%
> 
> 
> *FIO on SquashFs:*
> 
> 
> localhost:~/Downloads/erofs-utils> fio --name=randread --ioengine=libaio
> --iodepth=16 --rw=randread --bs=4k --direct=0 --size=512M --numjobs=4
> --runtime=240 --group_reporting --filename=/mnt/enwik9_sqsh/enwik9
> 
> randread: (g=0): rw=randread, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T)
> 4096B-4096B, ioengine=libaio, iodepth=16
> 
> ...
> 
> fio-3.17-90-gd9b7
> 
> Starting 4 processes
> 
> Jobs: 4 (f=4): [r(4)][66.7%][r=1175MiB/s][r=301k IOPS][eta 00m:05s]
> 
> randread: (groupid=0, jobs=4): err= 0: pid=34389: Mon Jan 27 01:07:56 2020
> 
>   read: IOPS=55.4k, BW=216MiB/s (227MB/s)(2048MiB/9467msec)
> 
>     slat (nsec): min=1194, max=61065k, avg=67581.76, stdev=754174.73
> 
>     clat (usec): min=2, max=222014, avg=1075.25, stdev=5969.94
> 
>      lat (usec): min=3, max=235437, avg=1143.13, stdev=6341.32
> 
>     clat percentiles (usec):
> 
>      |  1.00th=[    39],  5.00th=[    40], 10.00th=[    40], 20.00th=[
> 41],
> 
>      | 30.00th=[    42], 40.00th=[    43], 50.00th=[    43], 60.00th=[
> 44],
> 
>      | 70.00th=[    45], 80.00th=[    48], 90.00th=[    63], 95.00th=[
> 3163],
> 
>      | 99.00th=[ 28443], 99.50th=[ 41157], 99.90th=[ 78119], 99.95th=[
> 89654],
> 
>      | 99.99th=[125305]
> 
>    bw (  KiB/s): min= 1985, max=991826, per=63.49%, avg=140649.83,
> stdev=78204.76, samples=72
> 
>    iops        : min=  495, max=247955, avg=35161.00, stdev=19551.19,
> samples=72
> 
>   lat (usec)   : 4=0.01%, 10=0.01%, 20=0.01%, 50=84.82%, 100=8.18%
> 
>   lat (usec)   : 250=0.37%, 500=0.09%, 750=0.24%, 1000=0.54%
> 
>   lat (msec)   : 2=0.43%, 4=0.46%, 10=1.29%, 20=1.93%, 50=1.30%
> 
>   lat (msec)   : 100=0.33%, 250=0.02%
> 
>   cpu          : usr=1.76%, sys=16.29%, ctx=14519, majf=0, minf=104
> 
>   IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=100.0%, 32=0.0%,
> >=64=0.0%
> 
>      submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%,
> >=64=0.0%
> 
>      complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.1%, 32=0.0%, 64=0.0%,
> >=64=0.0%
> 
>      issued rwts: total=524288,0,0,0 short=0,0,0,0 dropped=0,0,0,0
> 
>      latency   : target=0, window=0, percentile=100.00%, depth=16
> 
> 
> 
> Run status group 0 (all jobs):
> 
>    READ: bw=216MiB/s (227MB/s), 216MiB/s-216MiB/s (227MB/s-227MB/s),
> io=2048MiB (2147MB), run=9467-9467msec
> 
> 
> 
> Disk stats (read/write):
> 
>   loop1: ios=177240/0, merge=0/0, ticks=199386/0, in_queue=75984,
> util=73.95%
> 
> 
> 
>  Fio Test on SquashFs dir:
> 
> 
> localhost:~/Downloads/erofs-utils> fio --name=randread --ioengine=libaio
> --iodepth=16 --rw=randread --bs=4k --direct=0 --size=512M --numjobs=4
> --runtime=240 --group_reporting --directory=/mnt/enwik9_sqsh/
> randread: (g=0): rw=randread, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T)
> 4096B-4096B, ioengine=libaio, iodepth=16
> ...
> fio-3.17-90-gd9b7
> Starting 4 processes
> randread: Laying out IO file (1 file / 512MiB)
> fio: pid=0, err=30/file:filesetup.c:150, func=unlink, error=Read-only file
> system
> randread: Laying out IO file (1 file / 512MiB)
> fio: pid=0, err=30/file:filesetup.c:150, func=unlink, error=Read-only file
> system
> randread: Laying out IO file (1 file / 512MiB)
> fio: pid=0, err=30/file:filesetup.c:150, func=unlink, error=Read-only file
> system
> randread: Laying out IO file (1 file / 512MiB)
> fio: pid=0, err=30/file:filesetup.c:150, func=unlink, error=Read-only file
> system
> 
> 
> Run status group 0 (all jobs):
> 
> 
> On Wed, Jan 22, 2020 at 10:07 AM Gao Xiang <hsiangkao@aol.com> wrote:
> 
> > On Wed, Jan 22, 2020 at 09:27:45AM +0530, Saumya Panda wrote:
> > > Hi Gao,
> > >   Thanks for the info. After I enabled the said configuration, I am now
> > > able to read the files after mount. But I am seeing Squashfs has better
> > > compression ratio compared to Erofs (more than 60% than that of Erofs).
> > Am
> > > I missing something? I used lz4hc while making the Erofs image.
> > >
> > > ls -l enwik*
> > > -rw-r--r-- 1 saumya users  61280256 Jan 21 03:22 enwik8.erofs.img
> > > -rw-r--r-- 1 saumya users  37355520 Jan 21 03:34 enwik8.sqsh
> > > -rw-r--r-- 1 saumya users 558133248 Jan 21 03:25 enwik9.erofs.img
> > > -rw-r--r-- 1 saumya users 331481088 Jan 21 03:35 enwik9.sqsh
> >
> > Yes, it's working as expect. Currently EROFS is compressed in 4k
> > fixed-sized output compression granularity as mentioned in many
> > available materials. That is the use case for our smartphones.
> > You should compare with similar block configuration of squashfs.
> > and there are some 3rd data by other folks as well [1].
> >
> > In the future, we will support other compression algorithms and
> > larger compressed size (> 4k).
> >
> > [1] In chinese,
> >     https://blog.csdn.net/scnutiger/article/details/102507596
> >
> > Thanks,
> > Gao Xiang
> >
> >
> 
> -- 
> Thanks,
> Saumya Prakash Panda
