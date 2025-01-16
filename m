Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B323A1353F
	for <lists+linux-erofs@lfdr.de>; Thu, 16 Jan 2025 09:26:11 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YYbYD3yt8z3c6n
	for <lists+linux-erofs@lfdr.de>; Thu, 16 Jan 2025 19:26:08 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=54.207.19.206
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1737015966;
	cv=none; b=hg6j1sEZlMcAbqsdGVhILabGuBLNvWSlZUHN7Q9S8yMvX+gmKubX52BHIIccoiuh2tyigN3Sk6K2zzbWGGS3wSfLRcDO939tMmURbwbzMnQ2Vw85x6XBvBxMiCwt66UivtgmwwobPOFhU//DqGI88R6bG+RwOVTmEwkTHzx/9tffvLPkZMS3YGDlG3eW67BL5jUoNqaQNF6D9BeqWdJv6REh5EHBqGh9RKh0E9efbf9HuoDnNP7zghFZSOR1pyZUSRXuYzKH6iLrHKKfiHZyJoil/8611VkTlyOAX7SPZRuy44rXaL5XSL+1IMbHCbztFYTEygJFraL+htDVwmvuUw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1737015966; c=relaxed/relaxed;
	bh=gTm8e6SdtocNO17gpQqtMq91lZB+9I8ezBdn4ReMllc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HEcrM+78eG7SOWvFGSUgQ13743hdKK2VY/nVPRae/JpL1LJzVxjpzToX5SUc6pR+K6Fiuoe1ZYpoLYuU3eDVCiA3ZM9bsgEqOzLATC0tsL6NC21QdtAmoeCQ9eUI4jVtqmWwyPGJ89tXX7gtYkYofFvG2shLNP2rJnxxMpvW4uzG1yBoG54ZJyuShy4mEs3GljidbrSAl+xQKVc45cb3+s7ljsfs2Aww6ni0tHSOJywkVpf3VUn836ShGz6h80e8em5OnTEkzFVT5t/1LJ2nxq2D1AEnxfuyqjM9wewLWIwG+3erD1BD7kzCm2bcdeM2VzzT6avjkSRKmigfyVGrJg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; dkim=pass (1024-bit key; unprotected) header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b=P71Wq2XY; dkim-atps=neutral; spf=pass (client-ip=54.207.19.206; helo=smtpbgbr1.qq.com; envelope-from=chenlinxuan@uniontech.com; receiver=lists.ozlabs.org) smtp.mailfrom=uniontech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b=P71Wq2XY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=uniontech.com (client-ip=54.207.19.206; helo=smtpbgbr1.qq.com; envelope-from=chenlinxuan@uniontech.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 3770 seconds by postgrey-1.37 at boromir; Thu, 16 Jan 2025 19:26:02 AEDT
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YYbY65GCKz2yn9
	for <linux-erofs@lists.ozlabs.org>; Thu, 16 Jan 2025 19:25:57 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1737015907;
	bh=gTm8e6SdtocNO17gpQqtMq91lZB+9I8ezBdn4ReMllc=;
	h=Message-ID:Subject:From:To:Date:MIME-Version;
	b=P71Wq2XY0fc3PIW3eiC7DeDJiTcLVVcgnYPE8gzdfNVKMM7frxycUg4MDfng2gztK
	 SAf7AcuxoTXX/s8owijTkPlZ3gX9MN0o3nW3NHY9NEZkRsylN2LRcJTjPxhuwO1JEE
	 Iysd9W7oYzZpxn643kM62iY7piJvVpOtNGRifNfg=
X-QQ-mid: bizesmtp86t1737015898t12boczh
X-QQ-Originating-IP: GsyHgMok/OSVyBvMV/n+bksW5hFEDC9p0UNSmu94xfg=
Received: from [10.20.53.121] ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 16 Jan 2025 16:24:56 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 13245521173636363007
Message-ID: <AC9D4F55C39C7580+c01e5ccb2bf8f14644d02a84ccc834ad49f86fbb.camel@uniontech.com>
Subject: Re: [PATCH] erofs(shrinker): return SHRINK_EMPTY if no objects to
 free
From: Chen Linxuan <chenlinxuan@uniontech.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>, Gao Xiang <xiang@kernel.org>, 
 Chao Yu <chao@kernel.org>, Yue Hu <zbestahu@gmail.com>, Jeffle Xu
 <jefflexu@linux.alibaba.com>,  Sandeep Dhavale <dhavale@google.com>
Date: Thu, 16 Jan 2025 16:24:56 +0800
In-Reply-To: <b33944b1-18fa-4a27-858f-5922ea1e1003@linux.alibaba.com>
References: 	<433DB98624BCDF95+20250116072042.189710-1-chenlinxuan@uniontech.com>
	 <b33944b1-18fa-4a27-858f-5922ea1e1003@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
MIME-Version: 1.0
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-QQ-XMAILINFO: OO3X4QYWmSnVBog3UqkV1Xc5exhATdyInuLC/F2K9ueU13I3mL1TfGxX
	faE+05xC8JIcK/mwsQ4NadV5K03fHzeL/8Ho+0H8+6Xi/uAzMIeQOyTFjcRQ69+2bWJp6VO
	ID1mB/Bt8cNnzpGgeZQ29MZOQKIGOyxSEOxMI7gbKR0qEf0JVr7AS12y0bBLZKX3B65zdLa
	ViaxcqlbhbrJBKG/FHoZwX4LxpacUE1FqPP+cLkZMsa1T5Rjs3dIsNKjW9vYpNPo1i/7QK2
	WJdXUjNR7TVfZChpZMCAvO0mVc6Kx58CDaaZOKG8GSfEXZ8sSC7wzEtg5PcEzZ806hfwK8R
	aPUwmk1Udks7r8tOQo8Tig3irK2oLa0OrQWXMODv+tUE3JQ4L75/8RxLq4PG6O/uTd4ipYQ
	wUgD1w1GXGh47vau1OUpkMrB/LI3QoxWvgNleukXth7AuHQQtCvJYgR/O3EbbKZL3LLwG1x
	kE4FmBoIwI/0O+t8pI8vYoL6WghNS21fyuKimlkRMToVtRHSywumVbhqcAYNZMhnxSuhbAA
	XBa9mwn+1QP1QAaVrBCnFVYeYhfg4JNE7eTvChWvSd9aojZqKeoT3OPVdnGCwBz6fPI3Lj5
	yRs7PFmi76nALgvzBWQU+jjhC0j7jEYI/x018HbJC7YHnGYPB8wAjNkWoCHjoif0ufFLi6m
	ozYOgzy+MXrUWFM2ALFXEelagQPr10tlF2UxjW05xhMyqFLCbCkhlUCV0Zf4iNlu4y5v8pR
	F7nbmSVc59sYcj42c5NA/kiG60toaazg7wBMFrJEy4r8+BHucru8RdxVBR/IKoUiP0TYupw
	RdBusbItGYMLRFeKmCtFdFiBVtFnvK1zBBw5sCsFHONaVZjcWlywI/GhceStfc0oq8k/UoJ
	eevi1DDKA1vjR9QBXHtlDUBB88mUjw8i3+GgTBEu1Cwwzgh6sQAWhdeXmbvql0Lhq/aBz0X
	PIV9xu1Htb7OBnnDuURfdOaXv5amTg/uWlcH80H7u8jBbDpu+aSJFeWZQAS8pmmNVJ4ZRU8
	KogrckRSh2ay2T3OZOuErGNZs4QN4=
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
X-QQ-RECHKSPAM: 0
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS autolearn=disabled
	version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
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
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Thu, 2025-01-16 at 15:51 +0800, Gao Xiang wrote:
> Hi Linxuan,
>=20
> On 2025/1/16 15:20, Chen Linxuan wrote:
> > Comments in file include/linux/shrinker.h says that
> > `count_objects` of `struct shrinker` should return SHRINK_EMPTY
> > when there are no objects to free.
> >=20
> > > If there are no objects to free, it should return SHRINK_EMPTY,
> > > while 0 is returned in cases of the number of freeable items cannot
> > > be determined or shrinker should skip this cache for this time
> > > (e.g., their number is below shrinkable limit).
>=20
> Thanks for the patch!
>=20
> Yeah, it seems that is the case.  Yet it'd better to document
> what the impact if 0 is returned here if you know more..

Sorry, I have no idea about that.

>=20
> >=20
> > Signed-off-by: Chen Linxuan <chenlinxuan@uniontech.com>
> > ---
> >   fs/erofs/zutil.c | 4 +++-
> >   1 file changed, 3 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/fs/erofs/zutil.c b/fs/erofs/zutil.c
> > index 0dd65cefce33..682863fa9e1c 100644
> > --- a/fs/erofs/zutil.c
> > +++ b/fs/erofs/zutil.c
> > @@ -243,7 +243,9 @@ void erofs_shrinker_unregister(struct super_block *=
sb)
> >   static unsigned long erofs_shrink_count(struct shrinker *shrink,
> >   					struct shrink_control *sc)
> >   {
> > -	return atomic_long_read(&erofs_global_shrink_cnt);
> > +	unsigned long count =3D atomic_long_read(&erofs_global_shrink_cnt);
> > +
> > +	return count ? count : SHRINK_EMPTY;
>=20
> I guess you could just use
>=20
> 	return atomic_long_read(&erofs_global_shrink_cnt) ?: SHRINK_EMPTY;
>=20
> Thanks,
> Gao Xiang
>=20
> >   }
> >  =20
> >   static unsigned long erofs_shrink_scan(struct shrinker *shrink,
>=20
>=20
>=20

