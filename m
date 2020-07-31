Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 76FA5233DD7
	for <lists+linux-erofs@lfdr.de>; Fri, 31 Jul 2020 05:54:28 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BHth13lsXzDqYb
	for <lists+linux-erofs@lfdr.de>; Fri, 31 Jul 2020 13:54:25 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1596167665;
	bh=8axpBvv7DssWN+XExxQhLQgJwllV4vNC7axlynXouhw=;
	h=Date:To:Subject:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=kqqnon52rPYHyidDEbRt7uOCuoNBimGRnwlnNZ27DfWtEGsDsXevF5zV7kOZbEBlU
	 DR2oLaBZhTfov6+afQfjFmMc3+Hy7dmukk14oXTIj8ui2jlTNukntVwVJp3S2WMofp
	 D+Sahb5hdrBIg4FTq6WfrJmRLryjrh/OTSjGQENT8wzQu/gSSL1VaoMy6nfqHtG1nf
	 bnnGFNX97o0wosOMwIKiwdwYT1kd6CTBQFPO7XkqNlCOpC39VesjnPRNJtoe4SRIRH
	 daqJYTGtRWwxabHPzqeUvBwQ4EEXHsPuZ61xPYkvJq6iYWEIH960z1UaJC+steJvrh
	 2vq1BEbI9ke3g==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.69.31; helo=sonic316-55.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.a=rsa-sha256
 header.s=a2048 header.b=jedJjKL2; dkim-atps=neutral
Received: from sonic316-55.consmr.mail.gq1.yahoo.com
 (sonic316-55.consmr.mail.gq1.yahoo.com [98.137.69.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BHtgq5gMzzDqYJ
 for <linux-erofs@lists.ozlabs.org>; Fri, 31 Jul 2020 13:54:13 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1596167650; bh=e1ptG1D791JJl8PSL08z3ayw20EnRWQZ+Ui9pEusVKU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Subject;
 b=jedJjKL22CSkEihifbFrur/93tlvsy57uLCo0S4tWStLPM5vMpDnZl/IGPIcYpKBkojqFdBn4uMvUQ3EulXVqskVPIiUq2nJMJrCwIcBV2/x3ak8AYi8wgkrgVfP44La5RXfq8fFJdu+rbDD0u2xEoIGK0oKND0B9nHPTivS4lZrpz4aDJy/8HZNgeQjkNB72GvXGA7mgrokOp/KRnR18BFN58b3X3853QDNlxzC3cLBJc6YgJU4zpsrlnrcLqfLV0rHbRYDEMmaJsNEXt6I6naEazKSouUUcJt0Z1j2nuQg462cdHlUFfoLvavxcDM8Wtuvbl7CRv68PHT2n5hC1A==
X-YMail-OSG: ISP22rwVM1mMvnOi2MknChjsIFIDaXj_IaM1AOX93e_cp4wu80ANzHYPb5B09qS
 PRUKBAVCGOAl_nOA4iguOe9dlO4mdber5.hETt4EznAyM7YIAyaWQHGwz_bCd153W.G2CbwfPzja
 1vOAl9mpQfbD4r99RpsEu8mGh12KLo3EKGDb4GnphKL5qShWJqpaZEEjHrzWoUytc6f0Qx.VcScZ
 39Pr_0FN1yWuPg8BIHM.fAI.95.OgCnhWeHLzBnjTXsoPq1B5oWLDPbIr_X2OrlzhTt31lvj8VqB
 3B.gTRxGVk2Ze0mwNI3ZnziLq2E57ohAYj7r._c6HUW4cvOO6AtG2bDCSm_93X4XjCiRfYWXTYzG
 HkQrYz6E_huJLqYkkPTGfYGZKII7G84PP5pt_fmxGufwwebHxFVO3tnRzD2xL0vWkPz5i6LP6lcR
 RYabzqwktit2zyjw.Yrc2nEP6pRrAtOGYj4dQXsAlnnnbszNf0RO4q2MMcTw5J5pZOP2KKCMh8Xa
 CUdt9G2Ho4pVsni_CsMmSHM6Z0YqD.EWFcOKS5D7_m_aQIv6Lm7OWx1NRQHplJYr1cTCh5c0pxkr
 QpH25AyKvMwtv1qYsx43D_kIkqIc0GTsrejP0odcOQR5U2HxcOerYIH7jFBYiyi81EoleDcVeAHa
 Jbp0HC5U_wGHvk82znzhCBwvkh4oNn0hc67TgssaZoS3IMGlupqimwX0KGZnp1qnUGhph0FezRQ6
 DQ_ct8e9VmF1wRJRtqejJ1zXw2Xo9ZzExRfO3j3tiigxTiPXzHcWMQWFqr1s6xjjgPRQDqwGHBxQ
 rlycpt8v7c4wgVBwjm6MFz982fxuacQfTWU_xSsGpIIGwx0dGyyWDv59ys0jrnnvUvG5tDaVlrG1
 9ElyflJkja3xkvNWE8K7xptnThOGWvL17AB3C4n_GZuQ48km4NCxt4vL70PyM3xHbAcin.fl7Ub2
 nndfNEpzNh38HGz7JeKQvBGxHEL7n_OcqnFzJ9LsE294Amr8vOZgLArLzPfMqXMVm_Ttiopmi3FE
 Yc8nJlBCkw_LAXvZdNI7mkS5v29Wrif2USkjd06GsTWdIHC.44JjwLihsLnoeIAdJNrFYaO9KmwV
 2FhIecvdNorJuxGmPXC_YFvAyDPZ9U4ZUa9wRCzPu3hMDxilAuidMqwbAP6OCr1WZNHNBsunKMa4
 u1WZMphYhZdCSE_UDnfSmC7NTE82IKXsE68RBU_msIQBebwAmQyNbleeDgyinFPxVsgLNge0wUVd
 F7b8VR0cHatpr1wSH8tuQxaWi4MW5moto6QVFh0gYodtVx46r4qGNYyq87TH7Hi8ep_GMWLLSuA.
 5RS4nvmJOSqmboOb.JJWLdeXL8exoPE29XzAYWpFVgnY4PnLMECnEhnYMiJrRkNweRZEaXg--
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic316.consmr.mail.gq1.yahoo.com with HTTP; Fri, 31 Jul 2020 03:54:10 +0000
Received: by smtp424.mail.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA
 ID 487ee864a61ff39844a03505ddc0ab34; 
 Fri, 31 Jul 2020 03:54:08 +0000 (UTC)
Date: Fri, 31 Jul 2020 11:54:03 +0800
To: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] erofs: fold in used-once helper
 erofs_workgroup_unfreeze_final()
Message-ID: <20200731035346.GA13780@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <20200729180235.25443-1-hsiangkao@redhat.com>
 <0ead5f4b-87b6-6fac-9e79-629880dec155@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ead5f4b-87b6-6fac-9e79-629880dec155@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Mailer: WebService/1.1.16271 hermes_aol Apache-HttpAsyncClient/4.1.4
 (Java/11.0.7)
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
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Fri, Jul 31, 2020 at 11:49:04AM +0800, Chao Yu wrote:
> On 2020/7/30 2:02, Gao Xiang wrote:
> > It's expected that erofs_workgroup_unfreeze_final() won't
> > be used in other places. Let's fold it to simplify the code.
> > 
> > Signed-off-by: Gao Xiang <hsiangkao@redhat.com>
> 
> Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks for the review :)

Thanks,
Gao Xiang

> 
> Thanks,
