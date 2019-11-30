Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F97B10DE43
	for <lists+linux-erofs@lfdr.de>; Sat, 30 Nov 2019 17:27:41 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47QGxk5LWczDqv6
	for <lists+linux-erofs@lfdr.de>; Sun,  1 Dec 2019 03:27:38 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1575131258;
	bh=riRUxNdMzNhfeMDrL6LmRqvE0y7csjZGbRDSczDXI7s=;
	h=Date:To:Subject:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=k4ixGxCOj5oySMbJqvzWwtsjQUgoMb6Gy9BIa2HxSwPL1+sDX4GIgHlLYsaLt8CQV
	 OdMt90MhSjebKnL/Huk0HdZ6DxhOBnbfKNsQ1Oy+Ey3EILWLdjau9BBTwt0cXJb8g5
	 yUKJ4c76Praa4+/BeF1SU8QXwFwS7E3fsIVQo+bFp9j/vN+37RVAXPgsVCNfRnnnOE
	 gCWYNHAlwABPQykQICoI/3uiq86JhaZ2cnrWR39R3lX4DOARCL3LFpObed0coFJk1F
	 kSPZZUqXTeeuVXztX5JuQDHlIi/VvpBbL0zb/C9ISM7pL+EfDFDj1ey8LRV4WaLQws
	 gwtSNKa7yTbWA==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.66.146; helo=sonic317-20.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.b="koCd/gSQ"; 
 dkim-atps=neutral
Received: from sonic317-20.consmr.mail.gq1.yahoo.com
 (sonic317-20.consmr.mail.gq1.yahoo.com [98.137.66.146])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47QGxZ0YcPzDqZ1
 for <linux-erofs@lists.ozlabs.org>; Sun,  1 Dec 2019 03:27:27 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1575131244; bh=yqP3F7KOvSiZZ61DKi9wU3BY84CGvej6H8ShhLDn6pU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Subject;
 b=koCd/gSQvOLs+4i9iHjTgZVSzwYYOwOAhhw1xJHOb2doNxm8txvczN7aq+WuXs7YEtub8OTGrko3iPMP0EorBPsZmP5LgW1utNDY/qPlFcTyzW5SzslxcOeppZB8mKbqZgbkN2huqQdiMqIoRmLAOyeeUbSVXHoWK5qJ4Q1wGXq2L9BxsXVYRLWI20INXkxaIKyRX+z7FieLu0I4NMyp/WJYZe0FvKebRGkWX7evljw6d2bYW6Oyc/VCIP8c3og7784Cxjyfmn9PhKeiSm2P04EpUMscuLkxlgXQRwTk2zC09ECCLazLJjpQW47Lynh08jXv7444O0uF7LBnksGm9g==
X-YMail-OSG: JZCHGPwVM1l2w8zC5uRWr9LkWNsrE9fGSxWVjou0XZaOx8.8kZM_yRcfWjxtpWk
 GlXMS1k2EQ6y8.3VbIlLNZsQJ5rN2DpXQycXDTcHGjw.XCC3KONojHTvf5BSEHvdQIPHMa1UKHw0
 zqYyoQwxO0..DOpAJCnBKVmbBppjbuHoonyQSVgSV39617crloqei5vaxz_Wny8gu5qBXOgd9PtN
 XR7vEZnB2_T6R3qa9EgkmzGBhPxuSzHdk31eG_1YhXvUf62tZ_MxT2wTG5h.NgEb_b5LrolHXs_P
 3xyEiDYAdOICPCMM6y3qkrjSNhKm.xoLBzycfZQQZnjZKG4MgOSbG5aZlJEPagovD29JygrZIyUT
 f4_8J5PtzSQHuNbN8x79aTu3Nh0eeBUgSpIDT23yuRb.DaArwWpqYSawGeNhEuUYSPNUlQFgkvDE
 2LMNZLQ6WULrfSvdnPUcWjp5Zmqy4ySxtnWwPSeVQZQA9CrMesw534toGaPhFdaK6XLjD6OjwZPC
 z2tPD6bMmwR7rzt6dAVm6JBXHa.vcLgY_VaavvYMLklKqzTfjv59K3tw0xT3D3j1FS6LriEbfK6u
 rCeVPl_BelnU0sZpQPrWodTAK.TQTokMzHl4jebp.2SfEryiuoULsDnJmQOUUbjhZsvadoh2QT8P
 LWzXpBdYb3CCDQCMXY0yW.tZD8xYAa7VY8kMX3MyfnF8bXHQVQ2SpmkLWbfcTqDMSRwpVyLNalKW
 tcXXvcnbao5NHUVwTQHkZadUJmG6ScGJHxDIoR26h_kmxM1j4iZ7zGafupshg5TVTzlbGuH5Kyi0
 Srv0I2u35l9qCpcQJhU56E6P6fGRajtOTqA7U1KtjqWl06Lfj9EtyJwTs.7TzwPf403.yWHXOHV7
 UiGYEMXIwMNYOGRE4f0oUwEnBaDLlRAcZRp6acieNSdkTNKHiZfgkZYkyXoS.h_iVkJP5uqReOtj
 XBJTs.C79QOuSLrHcWJ4Kt6hmDwDtL8L.E7JMru6JqblxGbQFePwhevBaT9Yhu6DtLQQO4ucMXrl
 w_KIpamD7HSGSuX5nu4c4ewtjVvyL7ZTugZRFKWAUGaAHBQ62dnAa4G0LGA5BHDk.f_eX1bElQnF
 5oWZkog3Bw6.vfyzPSapQgAoory.0Jw0veU4IDrhdGYny0mbuXlpzoa.Yrbqe78v60ASDSn70oC1
 Uepes_DUz8esVpfUfeamh6qtZsBTeq_301yHxANJcTrHI0sp0reispqKhSDEQElWOPPUctKTRb5L
 uE.sG21Vk9RVnXdeoElQOvsFN7vcrxuwntqE7FiQjpktXgzBJtINW0mDE0uOcdi85UJSVOIOgN9S
 _gEDlhv9AkpmMblASvuOurXQA4ywFnQ.Gr1t6XWbZJ0I4pcA4cdFf27LmN6kyExCUHoJp9rXX4Xh
 8EAQ1
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic317.consmr.mail.gq1.yahoo.com with HTTP; Sat, 30 Nov 2019 16:27:24 +0000
Received: by smtp402.mail.ir2.yahoo.com (Oath Hermes SMTP Server) with ESMTPA
 ID 1ef02d812a095c9b8752cb42c1aa1f6b; 
 Sat, 30 Nov 2019 16:27:20 +0000 (UTC)
Date: Sun, 1 Dec 2019 00:27:10 +0800
To: David Michael <fedora.dm0@gmail.com>
Subject: Re: Compatibility with overlayfs
Message-ID: <20191130162706.GA7903@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <CAEvUa7nxnby+rxK-KRMA46=exeOMApkDMAV08AjMkkPnTPV4CQ@mail.gmail.com>
 <20191130012900.GA2862@hsiangkao-HP-ZHAN-66-Pro-G1>
 <20191130021257.GA5562@hsiangkao-HP-ZHAN-66-Pro-G1>
 <CAEvUa7nG9Akp3Uv59P4+eGYYZ+nTfdO4OywiqZaLfY3_ag-vcQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEvUa7nG9Akp3Uv59P4+eGYYZ+nTfdO4OywiqZaLfY3_ag-vcQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Mailer: WebService/1.1.14728 hermes Apache-HttpAsyncClient/4.1.4
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

On Sat, Nov 30, 2019 at 10:15:25AM -0500, David Michael wrote:
> On Fri, Nov 29, 2019 at 9:13 PM Gao Xiang <hsiangkao@aol.com> wrote:
> > On Sat, Nov 30, 2019 at 09:29:04AM +0800, Gao Xiang via Linux-erofs wrote:
> > > Hi David,
> > >
> > > On Fri, Nov 29, 2019 at 03:22:15PM -0500, David Michael wrote:
> > > > Hi,
> > > >
> > > > I tried to test EROFS on Linux 5.4 as the root file system and mounted
> > > > a writable overlay (with upper layer on tmpfs) over /etc, but I get
> > > > ENODATA errors when attempting to modify files.  For example, adding a
> > > > user results in "Failed to take /etc/passwd lock: No data available".
> > > > Files can be modified after unlinking and restoring them so they're
> > > > created on the upper layer.  This is not necessary with other
> > > > read-only file systems (at least squashfs or ext4 with the read-only
> > > > feature).  I tried while forcing compact and extended inodes.
> > > >
> > > > Is EROFS intended to be usable as a lower layer with overlayfs?
> > >
> > > Yes, and overlayfs were used on our smartphones for development use
> > > only as well. I think it's weird, I will try it on the latest kernel
> > > now, and see if I can reproduce this issue soon...
> > >
> > > Thanks for your report!
> > >
> > > Thanks,
> > > Gao Xiang
> >
> > I have reproduced this issue -- That is due to erofs will return an
> > unexpected -ENODATA when calling listxattr without xattr and cause
> > copy_up fail:
> 
> Oh, sorry I forgot to mention I had xattrs disabled during my testing.
> I confirmed it works with xattrs, so I can use that as a workaround in
> binary distros until a fix is upstream.

Yes, selinux is enabled on Android, so every file has xattr...

I think it could be patched in advance if allowed (it's a trivial but
meaningful fix for noxattr overlayfs scenarios).

Since I've sent pull request for 5.5-rc1 days before. Considering that
it'd better to stay in linux-next for a while, I think it can be upstream
landed in 5.5-rc2 and backport to 5.4 then. (about 2 weeks later)

> 
> > since our products using xattr enabled EROFS with overlayfs,
> > so we didn't observe this issue before. So could you try
> > the following patch (If it can resolve the issue, I will
> > send it for 5.5-rc2 and backport to all stable version)?
> > Look forward to your feekback.
> 
> Yes, I applied the patch and everything works now.

Thanks for your confirmation. It's of great help to catch this. :-)
I'll resend this patch with proper commit message later.

Thanks,
Gao Xiang

> 
> Thanks.
> 
> David
