Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id EC590103763
	for <lists+linux-erofs@lfdr.de>; Wed, 20 Nov 2019 11:23:53 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47HzLZ0vV6zDqqJ
	for <lists+linux-erofs@lfdr.de>; Wed, 20 Nov 2019 21:23:50 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=mykernel.net (client-ip=163.53.93.251;
 helo=sender3-pp-o92.zoho.com.cn; envelope-from=cgxu519@mykernel.net;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=mykernel.net
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=mykernel.net header.i=cgxu519@mykernel.net
 header.b="HZwdBTz3"; dkim-atps=neutral
X-Greylist: delayed 912 seconds by postgrey-1.36 at bilbo;
 Wed, 20 Nov 2019 21:23:37 AEDT
Received: from sender3-pp-o92.zoho.com.cn (sender2-pp-o92.zoho.com.cn
 [163.53.93.251])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47HzLK703SzDqKT
 for <linux-erofs@lists.ozlabs.org>; Wed, 20 Nov 2019 21:23:36 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1574244490; 
 s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
 h=Date:From:Reply-To:To:Cc:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding;
 l=1333; bh=bI+cc8z3jGP2wVdb3YVmvSegQAtFB1j54+rsC4ghiRs=;
 b=HZwdBTz3XvGCjxDM6QZnyRQUaCC+nC4cUBoPKm+TiN0a6dqdrHeqeC1hezSdPdj3
 DHcv/3UA/Gbb44DaRVRRm0Iv9b/NEZQcPKrYkGtlBwXNbINsxYg4F8tHeES2NZH2qgF
 9PC5FM/A5Lc+opOV2VQv6Yl0DMfFxPw1cN+C3LQs=
Received: from mail.baihui.com by mx.zoho.com.cn
 with SMTP id 1574244487566843.4047643616209;
 Wed, 20 Nov 2019 18:08:07 +0800 (CST)
Date: Wed, 20 Nov 2019 18:08:07 +0800
From: Chengguang Xu <cgxu519@mykernel.net>
To: "Gao Xiang" <gaoxiang25@huawei.com>
Message-ID: <16e88489188.c48b2350794.7964821448665443701@mykernel.net>
In-Reply-To: <20191119125328.GA86789@architecture4>
References: <20191119113744.11635-1-cgxu519@mykernel.net>
 <20191119125328.GA86789@architecture4>
Subject: Re: [PATCH] erofs: add error handling for erofs_fill_super()
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Priority: Medium
User-Agent: ZohoCN Mail
X-Mailer: ZohoCN Mail
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
Reply-To: cgxu519@mykernel.net
Cc: miaoxie <miaoxie@huawei.com>, xiang <xiang@kernel.org>,
 linux-erofs <linux-erofs@lists.ozlabs.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

 ---- =E5=9C=A8 =E6=98=9F=E6=9C=9F=E4=BA=8C, 2019-11-19 20:51:13 Gao Xiang =
<gaoxiang25@huawei.com> =E6=92=B0=E5=86=99 ----
 > Hi Chengguang,
 >=20
 > On Tue, Nov 19, 2019 at 07:37:44PM +0800, Chengguang Xu wrote:
 > > There are some potential resource leaks in error case
 > > of erofs_fill_super(), so add proper error handling
 > > for it.
 > >=20
 > > Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
 > > ---
 > >  fs/erofs/super.c | 31 +++++++++++++++++++++++--------
 > >  1 file changed, 23 insertions(+), 8 deletions(-)
 > >=20
 > > diff --git a/fs/erofs/super.c b/fs/erofs/super.c
 > > index 0e369494f2f2..06e721bd1c8c 100644
 > > --- a/fs/erofs/super.c
 > > +++ b/fs/erofs/super.c
 > > @@ -369,7 +369,7 @@ static int erofs_fill_super(struct super_block *sb=
, void *data, int silent)
 > >      sb->s_fs_info =3D sbi;
 > >      err =3D erofs_read_superblock(sb);
 > >      if (err)
 > > -        return err;
 > > +        goto free;
 >=20
 > Could you give some hints what is the potential leak exactly?
 > Actually, it was modified on purpose recently, see the following threads=
:
 > https://lore.kernel.org/r/20190720224955.GD17978@ZenIV.linux.org.uk
 > and
 > https://lore.kernel.org/r/20190721040547.GF17978@ZenIV.linux.org.uk

Sorry, it seems I misread some part of code, please just drop the patch.

Thanks

