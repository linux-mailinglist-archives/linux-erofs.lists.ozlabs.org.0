Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CCCE1F9AC2
	for <lists+linux-erofs@lfdr.de>; Mon, 15 Jun 2020 16:48:44 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49lvN76rCMzDqMw
	for <lists+linux-erofs@lfdr.de>; Tue, 16 Jun 2020 00:48:39 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1592232519;
	bh=Z99ThWGgJ7MkNwlFRhMPokoe1wLdEvHRMhKurY49Yl8=;
	h=Date:To:Subject:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=Grz3UbHkMuIViH2y3dBAiH9sGQ1XeDqSDGQXcSo/Gm88MLz+GgRnTPa4gZNT8eQ7y
	 5XIWOwI6r+i/rceJfdMpDd1CJ6HOVZWKWCabaDLCQX9s9sdj4WKfbKJhX7Dc6IGR9j
	 zrAP+JDwZGKBI4V6pMYbFwlePr7s7JWowLe8hiuyqAUhdEi2YlZv7JSYO87hyF2N/V
	 adzFtKGUWCPRI2Rl7GLNXV/glYYCXfQ314YvfGhsR3HUPuWYAPpVOBpCXDSp+p7v0Y
	 COCQ2iPwHOJa0t3A1b8svozuUKBHotglyGkQc+C/3lFrN24P8IaR0R58pjgBEAUqwU
	 SMv5KCLtd2gZw==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.66.146; helo=sonic317-20.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Received: from sonic317-20.consmr.mail.gq1.yahoo.com
 (sonic317-20.consmr.mail.gq1.yahoo.com [98.137.66.146])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49lvGs2bn6zDqYP
 for <linux-erofs@lists.ozlabs.org>; Tue, 16 Jun 2020 00:43:53 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1592232226; bh=9vLRB01bOItG254PL9Ughn8oiOkNFLiMPoFOQSIRr9A=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Subject;
 b=McdAXOI0SK91Vz0xX74PhfL5P2TgLcwngFFnlV7049RKJjowhaOF4J+m2IsxoFyGXAscZe10LkddHFfTvk1j6G81InXAXiwrvEyyqNdioplLebeqZ7/RhADAJv8lJNnAc3wmAcPOWjR0daP7kqux9/5v7AEOQT0QeRdJfaFyKurVjK2hCb3yfE3y0PMgzofHeOKxlxesBiqKeo5Z4ZyvDMgIyCtYxb1TLnCTdJHjoR7/bRLWCo4HROFP1Rx5r8QELEftwlC8u4vhWlBp+fwQgOmllCSPwHuSAQ06y6hKFekXQe4S2Utxk2EmRG+QU4QLn2YjwJONPrR00epIG7ANZQ==
X-YMail-OSG: RbY9pOEVM1nNTxMzGhZTKJimI3Sr.bLHfJ5dF_fEIk2.Ogbli8iKLeyj4Js6LiU
 qnKKBWpOm7Mn5hNYrHZEaPps2D_NlRBviwOoPMuNK86a8JLG8ul5HOCjbpHFt6YdEU4x9ix91r83
 .kldqMPZigrMJflQQJBqx5Lu6XtjnzBCLILnxp2TjEvCRpRQcwr8PilmdgIpEdre4RoJT0T8HvmL
 d0NkOyihYnIO49DQ1LvKWbtdon.MIMt.c4QrWS6BXnjGgcUt8nMhFnU663UiQakqff12xzLaVZi1
 pnOTv15XfmNNCXj8ARmy9_9jGSKfguUJ8D85p8ShUDMM1AFLbtPLnwW03lvnNGpg.6H1rJpGkeDe
 aFuFGcGAjGcX.Bwue.qDTTIiBAdbvev_aKTzVtNe0CGO9BdeO1L4rccSZ7VZg3BKlPkVJ.ZttJAy
 0f4m9SvA9BqF1GlPvtRIu5gMTm4ACb7gI1aIt_MFuCJ_KhijbOGlER3njjzfjflAfPNkCViqa1Yo
 o8HqgrySbt.H6oZsJ8.884MG1HdKjYmMkFkSF04sPIxtDFM.5uljeiyBun7UVmZrI8emlFOe7Xp7
 .ly4FKGO59GWJa_6j9G71KyvuKSqIn5VqKmQDFgDWhyuofromUNne.SDIskxxOT0xdhsm2puBFdm
 PtmqeRgc6fX3FAzi1ho2NiMi03ltL3QpWBOosxVWSzJTsl0lk6dIKPIufeayl2Z0utGGGsIRVeg5
 G0mb0C.w7shlGKfV9QNv1h82miygDpOYa9zwCHJKyS8EOLWusts0TCv9.rc7MopOEwyS0SdUfTgM
 52oFvqvIM.5y.iu6yhUXdaEk4A8l2GDGpM8SXCWk6UI_YFLOj_YjmIX9hrp.keF27X7EOfntNCgd
 rRtcZhXXAdxYy5KAFRjcsaH_j5lINcbyvItpZgY8ler4rx6qf.NZYtq4wMpnMLUQO7HIgWigdH8O
 h.2BYrIeJ26kLZPt4aKAYmO8KRD.l9ob1fK9YkBG5dZV6iBvY4uCw5taKzzkQ.EbF5O31_hPKZcp
 MQBWkd7YYQ23GpIH41COY0Y4R4ipV1yY9KqP83SeN7dS5OlwYW3osFQ_ddS9N4igKHl41YhuyrG3
 nDZRsPhZp0QilpOn8aQ94mAlhT6VuV49.kHbqVUAWUu6XuIQ44owrczxHeOzXo9NGu6XCX3t8epl
 8pe.lZVwVm3r6qwJV5N0eun8xTj05cLT3_RNmzBpgZ0A0FHL.15W5ot8lXf.mrkAvjRxdy74uK_R
 9NMf95q0AIukORSljkt8idNNHoGUpzYA9eblYXYvVI7lp8to4LdePSPfeCsp3t4YMyDU8Ny9oOQZ
 Grz08Hu9cf6Fi1OH3d.0uaAMCZ4KQfJ1KsLHUoiTEYO_.WFnfkg.vMOEVSxqmj8xUsV_zrzLVf9W
 B
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic317.consmr.mail.gq1.yahoo.com with HTTP; Mon, 15 Jun 2020 14:43:46 +0000
Received: by smtp423.mail.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA
 ID b174da9218f63a9312af64204256e53c; 
 Mon, 15 Jun 2020 14:43:41 +0000 (UTC)
Date: Mon, 15 Jun 2020 22:43:30 +0800
To: Li Guifu <bluce.lee@aliyun.com>
Subject: Re: [PATCH v3] erofs-utils: introduce segment size to limit the max
 input stream
Message-ID: <20200615144323.GA16511@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <20200610171728.7303-1-bluce.lee@aliyun.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200610171728.7303-1-bluce.lee@aliyun.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Mailer: WebService/1.1.16119 hermes_aol Apache-HttpAsyncClient/4.1.4
 (Java/11.0.6)
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

Hi Guifu,

On Thu, Jun 11, 2020 at 01:17:28AM +0800, Li Guifu via Linux-erofs wrote:
> Limit the max input stream size by adding segment compression
> (e.g. 4M segment size), it will benefits:
>  - more friendly to block diff (and more details about this);
>  - it can also be used for parallel compression in the same file.

Subject: erofs-utils: introduce segment compression

Support segment compression which seperates files in several logic
units (segments) and each segment is compressed independently.

Advantages:
 - more friendly for data differencing;
 - it can also be used for parallel compression in the same file later.

> 
> Signed-off-by: Li Guifu <bluce.lee@aliyun.com>
> ---
>  include/erofs/config.h |  1 +
>  lib/compress.c         | 11 +++++++++++
>  lib/config.c           |  1 +
>  3 files changed, 13 insertions(+)
> 
> diff --git a/include/erofs/config.h b/include/erofs/config.h
> index 2f09749..9125c1e 100644
> --- a/include/erofs/config.h
> +++ b/include/erofs/config.h
> @@ -36,6 +36,7 @@ struct erofs_configure {
>  	char *c_src_path;
>  	char *c_compr_alg_master;
>  	int c_compr_level_master;
> +	unsigned int c_compr_seg_size;	/* max segment compress size */

Add a command line argument "-S segment size" for this, and
update the manpage as well.

>  	int c_force_inodeversion;
>  	/* < 0, xattr disabled and INT_MAX, always use inline xattrs */
>  	int c_inline_xattr_tolerance;
> diff --git a/lib/compress.c b/lib/compress.c
> index 6cc68ed..8fdbfb2 100644
> --- a/lib/compress.c
> +++ b/lib/compress.c
> @@ -32,6 +32,8 @@ struct z_erofs_vle_compress_ctx {
>  
>  	erofs_blk_t blkaddr;	/* pointing to the next blkaddr */
>  	u16 clusterofs;
> +	unsigned int comprlimits;
> +	unsigned int comr_seg_size;

Let's update the whole logic as what we discussed on phone just now.

Thanks,
Gao Xiang
