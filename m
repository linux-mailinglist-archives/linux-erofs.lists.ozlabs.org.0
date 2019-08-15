Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id E67088F18C
	for <lists+linux-erofs@lfdr.de>; Thu, 15 Aug 2019 19:06:13 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 468Xsb30FKzDr7Q
	for <lists+linux-erofs@lfdr.de>; Fri, 16 Aug 2019 03:06:11 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1565888771;
	bh=jTQmqn/VyCGalamylRGP22O3UHEwjsueF6sZ37ZhcKI=;
	h=Date:To:Subject:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=aQRmOzHiCQPMyNuXdwATafHNXWIhjtCEJZtYTIQ2ZhhOvg0qKYB7nbugwb/LwKBI3
	 +MU4g5MS+GQrKhmqrJFbibqyaPuPfcKftOlPmW69Nq1ZRUnDZTeQ/dj+vD4/D/hhMu
	 oABKKLe2WsndJhDpy61u27A0S4Qf+r9eVLSjbv1To5xtPqaG8zklH/7Q2O2xKijBYB
	 7Cu9swbQatSjNE702RkiE8H2f4DXVPPPoOMSrAJrLweKpYCIzgEbvWFP4b4CzsH0oH
	 Z+maPoz3j9ciUAzraFXOZEtyKTR7KcVsnX7UakFxegQkKIumIEDg+zAuT3n/ItRo6e
	 Zjj0U+unkeGig==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=aol.com
 (client-ip=77.238.176.99; helo=sonic301-22.consmr.mail.ir2.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.b="HDOdOuua"; 
 dkim-atps=neutral
Received: from sonic301-22.consmr.mail.ir2.yahoo.com
 (sonic301-22.consmr.mail.ir2.yahoo.com [77.238.176.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 468Xqr3rwDzDrB5
 for <linux-erofs@lists.ozlabs.org>; Fri, 16 Aug 2019 03:04:40 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1565888674; bh=B1CDKmFfj6aDeTiNOiZadWEgT+fWeNQZxcrgAnVsmOs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Subject;
 b=HDOdOuuayJtJ4At+QPaPyvRwQCfBsUapF49QasrPrPcoc252mv8LHcNr7nXZZpsa4R/w0rw4WA4xIStpwqmQ40wDlNFvzHHNZpw/8DEMsR2eGPp215VYPIAXK5Z8mmaQI43ltmJzM3xplwtyYqILGlUUpBiM2wAy0OtqGuPUNGehJCt4l2PzMxkrzGRlkYXb5oyoM2RnGH1ZrYlW3LBYizvW/hsaVNw+Mc6BEHtoQhex/oFj+i1DsDvGpxV3NfqFWwKHn7RAiEUl+sB45lz6xMp7Oht9uQNNmVeqauMY0wBuFuUMwdbMS0Ypkwwpnh6nFwe7XPVO6VMktbruGsb0rA==
X-YMail-OSG: UCM0UGEVM1k.ECZKTxS2OqaNxzGHhhZ.pF6bQgH1V5pop2SUDTzFWfBv_5CJXjN
 lmzvdcgsctqscHstS.D3ySu2diMWMVLd1NlS_.QLBfWHJgiZJNUUORUdNzd_1JBEHhl23GXEI9Cr
 SkA.ME94KDhq3JYnKqfxE3lBqx1qsUoxTDPcsaK7CSV9uXRuC_rVeJWQGHFrLSxBUMlfKTCwLK1Q
 SRwutEVv7UDXOJfgMG4dfSMV8ocaxYvcBM__Q2ClXC6IYJVrJ4YY.flrgyQVVBvoCL7eNBwLxq..
 E_cKvKeO5.MMCvhwZl.6UTiEJwVPemSOCL9d9MpkZyzrjgsHgpLwmbmm4TZE9yC7ZV5IgDV.cfqj
 6yNGkLoZdle_xiEedxjALL37oIp1kh0B0AnA.rfKPdq.uwJVIgTQW3DfVqlf6iKhB6uy5RFkNXRD
 IlR3ZLEMzYftGCwgQzomL.99B5RdayKOfbP7ZfTyQFsQfXaxma1dQwsDzs1eJW7MlH6NvdnIH6v0
 bl_66yAONv0NOGPRWVKJ2AUkGWWM5HBJDnqQZDhfj2vYWjXijuZiUOYh218tDbWkiNOWjMiXRv5w
 Nco0gD6FUD9TZNJowGp.fNnHLIWQcSoJvyGArd42Ffch7Cx6LrmtIkLSBB96xZiAkDsIdZSQCSc6
 dkew2LYcnzCsBKEhae3KwsT1sQGkuPPJHLa0xazi.g4qhenO1N9UemS55UuwOF0X0QuNam0ArZVe
 B33q0v8eDbA3TkRAhrspGG0NCt8Bw54BjY6.zQd4f7PTFB76.fPLd7UUF5LElwll.bgQ7L6fQplJ
 OkBMAzSujJwqSD6EqYHLE0a5NAsbBhO9VISE_me1hH17bSBl7PczHs72rzmHz7y4Ct6M2jZQpSB6
 tHWM.i.sGQksU1s5UcKLX3g9nFurGU02ehnJtJH_DkBr5b75yV8_Kwlosn0Z.4gGb_AUmPY7CvEN
 MUT_Hs1lwsxl9CamXd_8IYJNCuCjCl439CIsZhETFo1_kc3Ym_ysi0jzwtdzhSf3nvYG65HHjczN
 02AhHEXoNChDFLMmb35Zbz597Zwjb_yN.f8l32.wP_8j2dFd61e9qAPZ9feIO1mnYh8jMP9.8gtC
 Iuhc0t6IPpsXPvLhXu6mLkFuALJhX9VT7QJomXTsg2k0BTOmxpOPmc4KbWEtgl.qKtaeqJBXu.Lh
 U2PQwdOgTlMhmhp4bmv2LeLI40LC8k3GvxgXsEOLJJHFKc4uiqRbwrVnkKviQ..NTaE3gXl6T8yc
 dtaTogao_6wD2HNBCXC2GNMHbgcUmop8L_06agRcMtFBrCsI-
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic301.consmr.mail.ir2.yahoo.com with HTTP; Thu, 15 Aug 2019 17:04:34 +0000
Received: by smtp432.mail.ir2.yahoo.com (Oath Hermes SMTP Server) with ESMTPA
 ID ed96a2e86c060211f0b97b71e44301c9; 
 Thu, 15 Aug 2019 17:04:32 +0000 (UTC)
Date: Fri, 16 Aug 2019 01:04:14 +0800
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v8 00/24] erofs: promote erofs from staging v8
Message-ID: <20190815170409.GB4958@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <20190815044155.88483-1-gaoxiang25@huawei.com>
 <20190815090603.GD4938@kroah.com>
 <CAHk-=wjKz7JLd=mj0w2LUiWC2_VOeNWhTTrw1j-i-KyEHH5g5w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjKz7JLd=mj0w2LUiWC2_VOeNWhTTrw1j-i-KyEHH5g5w@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
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
Cc: devel@driverdev.osuosl.org, Stephen Rothwell <sfr@canb.auug.org.au>,
 linux-erofs@lists.ozlabs.org, Jan Kara <jack@suse.cz>,
 "Darrick J . Wong" <darrick.wong@oracle.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Amir Goldstein <amir73il@gmail.com>, Dave Chinner <david@fromorbit.com>,
 David Sterba <dsterba@suse.cz>, Theodore Ts'o <tytso@mit.edu>,
 Christoph Hellwig <hch@infradead.org>, Pavel Machek <pavel@denx.de>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Richard Weinberger <richard@nod.at>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 Jaegeuk Kim <jaegeuk@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Miao Xie <miaoxie@huawei.com>, LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Linus,

On Thu, Aug 15, 2019 at 09:18:12AM -0700, Linus Torvalds wrote:
> On Thu, Aug 15, 2019 at 2:06 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > I know everyone is busy, but given the length this has been in staging,
> > and the constant good progress toward cleaning it all up that has been
> > happening, I want to get this moved out of staging soon.
> 
> Since it doesn't touch anything outside of its own filesystem, I have
> no real objections. We've never had huge problems with odd
> filesystems.
> 
> I read through the patches to look for syntactic stuff (ie very much
> *not* looking at actual code working or not), and had only one
> comment. It's not critical, but it would be nice to do as part of (or
> before) the "get it out of staging".

Thanks for your kind reply!

OK, I will submit a patch later to address your comment and
a pending formal moving patch with a suggestion by Stephen earlier
for Greg as well.

Thanks,
Gao Xiang

> 
>                  Linus
