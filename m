Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 085369169D
	for <lists+linux-erofs@lfdr.de>; Sun, 18 Aug 2019 14:39:34 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46BGpV6KVVzDrCt
	for <lists+linux-erofs@lfdr.de>; Sun, 18 Aug 2019 22:39:30 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1566131970;
	bh=7Aq9E6MKyNGVBCPw/mx5+s0qodI4slJyXu9QcR8lL2Q=;
	h=Date:To:Subject:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=hpwsj95JAvO45Hpm7lJR1mkV+VPENl6TMd9/y+P/HPkk2O6zXMxDgM0yS9F8VIFBb
	 DhHcwtBUMoYhixIihDf6N4X7hZscLQTRfwd7ZS/BQZO0eYLEfVRjDtd/szGLq0Y7dF
	 Ee8Nn609Oa3BFeJ7T6ViGROTzk1mSIAkYaWiBTjs7DljaYiGSKJPNxkp9j0gg9CDPQ
	 k1+xIfX+6XiSo/RKMpaZAzu+0/SdxgovXdj6RLJYFZs19GS3C/EUXPPamIeIQEqRhf
	 g4mTzYjNkJFa0+sPpvFNNSsa1RPoPr0xc4czpXqHrDpc+2kyjny6h4pe3Jmc0l8bVE
	 LSsT5V6X0yekg==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=aol.com
 (client-ip=77.238.178.201; helo=sonic303-20.consmr.mail.ir2.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.b="Xot5PEC7"; 
 dkim-atps=neutral
Received: from sonic303-20.consmr.mail.ir2.yahoo.com
 (sonic303-20.consmr.mail.ir2.yahoo.com [77.238.178.201])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46BGpN0s9FzDrBs
 for <linux-erofs@lists.ozlabs.org>; Sun, 18 Aug 2019 22:39:20 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1566131952; bh=/mcEyNhNZdsxaziyro/9XUfTujsutguSM01LgK/G9go=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Subject;
 b=Xot5PEC74D+HgmV+TCCZeYFy6AnigD1cyEBX8QWCJk3pUpX8zPoUMDeGs0PpBwBHlnZ+bN8qXhRhvgbCO+DWhLuYkWdsNNB38gNdvaGg/YbxtIsoETx6Y2yd9OJ+DNglj4vT8Qul0jfZLurzMQRcLuox4AECFPn4jLp5El5/7x/Qw3VF76zsurmTDNcLrikmdEyBqw6VzghCRAsl0emD+7LPsga9AA3p955+6oKS/c0H3wTsDgolCDB9lJjRqEW98xocNnYekYjoHQz2VhWaiiC853ifxbMuXNDveYSGLAmcRjOn9XGCZvS7r3vWustd8ki86kEcPxd+nUMrOoyaRA==
X-YMail-OSG: UMCkWz8VM1l9vNkW4JU4htKV_mYcjxwTdIV2UF0tjG9JBHO3MMC9tiMszAh3BKd
 E9.IN.N91FE9PQ3sqyBEsQBhD4XxXZa8JIJ_FMcbtJh3odq7sEcz50mM3JhE0zplQaL0reahqMJf
 z9l6F3ENMtq4oOlE8N9M2Ye33R9f6Q9Vyi1Eier3vUhKZ8RCLFi0dEirJLqSaoov5YbBACGhfi8A
 nTRfhtzo7ksFrek3u9TvBO.lbMx9vzG2C4kgzui2KbRvTbloz8VyT0c0qa7NkXAlsSyuCp50ZHyC
 STEEIJuFsluxa8SAbHHYovvLXotocjVR0Ble3JwpLw93H3tzgrrkSZch_pm4DGat_.pIUaUVx3Gz
 vyMQFlnKGqgaoqLuhOKfAcyLM1sRz8REHv7DnRFCXVJaHYJMAxySgvW20.TmkB1xpLQPyim6iGBw
 wFfxzsWl8r0xuz1qkvjYJSLNcMj3vVuCtw07GLVV0k4ari3ncVcxB_n69rAi0xkYCSDdKMSXAvIZ
 AhS9j.W5jg6EiNR0Rttgsc.0WAMoJCvzuKtXAsqHzhwHPg0zJ2l8_cADSAQhKtNdcdQw57iJGWQl
 sqcUI6zzHm7eJww1SfLsCOWuczmSpAlMd_uYVldz4ZDCTPbbkmWcbMggLDiJxurX6YbLS.Kq6Ofi
 OETNnJi9gGZZpWYcjawQbWoXw76gkt7Bj9yFsZ6pPpbvcNInJfuFgxns4RKTQTwPd3xopxhx3s.2
 vwKQeMk5_qmK4gLbjWIJ1UHjv08KeDcN7PNeaSsHgK2TgNuBjLNJkGmng7sX7YEd8tv8ojI7szhv
 Q8KJIc5PFE07FIxRo0wbbZu4UOA_vo4SJL5PzCEqumEU4EDjI9osindldRhONALQPXaB_ShhFcOv
 VTH3Yac.8iMTBPSpw6eJSg5mi0mA.iKxljB.wDfliocg9wdmWI9mPq7QHTrspZ_rtBeYruryIBH3
 6jRsZ2ff9IuDL8twvrAvAr8De4qskXNj4VdZXSbCRI13kh6q3Peq2S_MISVj3i8ey8ZX4Mm7HtIl
 39EtaW9XtsItCjSqT5H5Kb4a85IwSerEd0ugfhkM0oDtYFgVos88j51BM7l7XUT4Vw8KPGcv4xQz
 r_cQ5.R826I5LBJQQtyGIiN3n4Y_kLXtOhBeCccsFmdm9ypJGFCy0uf.iRGJWapTdM10ilrDdcI_
 ZMrNUUaOm3PY8dQo8u.1NtMRcuSyuOf76UIcbvRLZ7pdZS1DDUnW9NkzxTLL1D.XPLJbS.4ohDgo
 Ix8iaFtqDqUpuHCNeSGUmjRRmT7IMoq_A0jU_5Ys5pA--
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic303.consmr.mail.ir2.yahoo.com with HTTP; Sun, 18 Aug 2019 12:39:12 +0000
Received: by smtp403.mail.ir2.yahoo.com (Oath Hermes SMTP Server) with ESMTPA
 ID 5ac8cd491445deee6abef8e6b8855acd; 
 Sun, 18 Aug 2019 12:39:09 +0000 (UTC)
Date: Sun, 18 Aug 2019 20:38:59 +0800
To: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v3 RESEND] staging: erofs: fix an error handling in
 erofs_readdir()
Message-ID: <20190818123858.GA24535@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <20190818030109.GA8225@hsiangkao-HP-ZHAN-66-Pro-G1>
 <20190818032111.9862-1-hsiangkao@aol.com>
 <20190818123314.GA29733@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190818123314.GA29733@bombadil.infradead.org>
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
Cc: devel@driverdev.osuosl.org, Richard Weinberger <richard@nod.at>,
 Miao Xie <miaoxie@huawei.com>, LKML <linux-kernel@vger.kernel.org>,
 stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Sun, Aug 18, 2019 at 05:33:14AM -0700, Matthew Wilcox wrote:
> On Sun, Aug 18, 2019 at 11:21:11AM +0800, Gao Xiang wrote:
> > +		if (dentry_page == ERR_PTR(-ENOMEM)) {
> > +			errln("no memory to readdir of logical block %u of nid %llu",
> > +			      i, EROFS_V(dir)->nid);
> 
> I don't think you need the error message.  If we get a memory allocation
> failure, there's already going to be a lot of spew in the logs from the
> mm system.  And if we do fail to allocate memory, we don't need to know
> the logical block number or the nid -- it has nothiing to do with those;
> the system simply ran out of memory.

OK, I agree with you. There is a messy of messages when
memory allocation fail.

Since I don't really care apart from crashing or hanging
the kernel, I will resend the patch to make you and Chao
happy... :)

Thanks,
Gao Xiang

> 
> > +			err = -ENOMEM;
> > +			break;
> > +		} else if (IS_ERR(dentry_page)) {
> > +			errln("fail to readdir of logical block %u of nid %llu",
> > +			      i, EROFS_V(dir)->nid);
> > +			err = -EFSCORRUPTED;
> > +			break;
> > +		}
> >  
> >  		de = (struct erofs_dirent *)kmap(dentry_page);
> >  
> > -- 
> > 2.17.1
> > 
