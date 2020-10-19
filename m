Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0604C29217E
	for <lists+linux-erofs@lfdr.de>; Mon, 19 Oct 2020 05:43:51 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CF2fr1cNkzDqXG
	for <lists+linux-erofs@lfdr.de>; Mon, 19 Oct 2020 14:43:48 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1603079028;
	bh=pkeTT6wTv94Q6DpGnFRXt09OhVjjp5jvOXd6uaCw0/0=;
	h=Date:To:Subject:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=DFc7K9sDHPxchN917BpjPcvlsWRbntoKH/FR0+J6vkyfXJemH/s+THWJGQrDJiWQv
	 1VqOGj5jb/GDH6zGFzvo1CfrR1oVgfmOUuEW14KoKlcLYbgPjulT1wQzpJZSt9m+B+
	 fO/XPif7QtJBgWroXj8U7IOAXDFNUBO06i6Cq21XzwHQ0Fgz+XWzr7z99k8lLqOpbm
	 GPb42ZTDmk7NcfMaCYwkgPmzcMWZ/6SBQFetAVXC81Rhw//PEbBb9OfRc0ZjRklDiw
	 QOirjky+zZ6uf2awZiBX9zVqLMQK0upFYADb//8n3U54ptVqkM+cX/oHTkwvtWa5KN
	 SFmMrcfqu0ikw==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.65.32; helo=sonic315-8.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.a=rsa-sha256
 header.s=a2048 header.b=amzZYGg7; dkim-atps=neutral
Received: from sonic315-8.consmr.mail.gq1.yahoo.com
 (sonic315-8.consmr.mail.gq1.yahoo.com [98.137.65.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CF2fk5MySzDqWt
 for <linux-erofs@lists.ozlabs.org>; Mon, 19 Oct 2020 14:43:41 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1603079017; bh=pkeTT6wTv94Q6DpGnFRXt09OhVjjp5jvOXd6uaCw0/0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Subject;
 b=amzZYGg7kDNqo9W6YJLAR3S/hQhvVV8hifIQgBx9tWNKcUKF3nYyNUb1nbsaW265rwszY9mstQTSH3XAQevWJCRZV5MK+c8/gQQpkLvZDAhjzAcPy8v+lS2yyQ+ID3S50AstPlqdkvt7/MEtoRr5oN3myIKYQhcO3bn/54LME91cmFUWS0X2H+gQp/EQ1jx8+5t/XxrxjrPfKxjsd5WGGYXqnqxituDF9sIpthL2LRElVGIm10Bgty5BHQJHddqy4P2tXxeldp/mMBIgu1duwG4e1mXRILsS+Ai0xgEpbJJSKoigVKhxVdiV8UWIm1O3gPHtNoGeyr98OtrXHbjt2g==
X-YMail-OSG: dDc3OrgVM1ld8QKSoWUiOzD_TfckrRRRZUwp1g9K30RuqIJ0aKclXLBUdLFaxTO
 uCb45gh9ozDT6Au8vAJY8VtI3nKwkTRqNkgl9p9OHTGrnr3YVamHV878u_djbUkleZNYhKyVWqi7
 6IWSrorWSxDvO2a5rEeUYQ704MQzs_7VfMVbCSGa.kH_honWTifQPqKx2Ci0iogN4BXNkgNI8kMN
 kCjXSqc.DIGBWu4kAKI1p.nv9VrwCdqDv3XYBQrrfmIyHrnH9xr2KJlDqIpjMp799vu81vV85xyI
 x6ywUTTvaJ2D6Ke.Cq_fztHWDoy0MfsdOCOnlaL6GOcEmIn9CqRDMxQnbAqPJHVX7Zw97OCIo7tr
 fU6Nhv.LuNzoIxUhVCQLTQZwMUQAEYcjR7QcFgUtwibLX2TAEME77O1LeH6VGPEYZJH9LWv00Ty9
 7HAsHeSxFXV8NjmymBU.CKSjSNFOVbVB2D_n2idOR2yfOAEZ6mzxgiUGoI_DrBhilOrzZzxV7cuQ
 TH7jzRkvg_DKQKS4nbM9s3imfBzxkWJnp9vxxDqhD5urHDiqGLOHmEclbydjnGePOqNuHRFTEWWx
 WRfQnUqOYDQvGaoFCbndILv_qrrMa0HCtJ9jdLtfsAcDtidgf.It9pcwzKIfP2A2d6ePatEolDXI
 soLpyvzmzzFxI7F0hPPqqN1lpWZDkidG.sirOmsR4y5oYuS7dYnwjE9Bwp49Bd4oXDZrxDkARjJP
 hT3YQivztuOqp6sn.KvkFh50YmerbIQnPomTDXj1FW3Qd9mrXFNY0vZ7aGfeYQcCbhEpFkWfkSWN
 Sb8BRTgJu92uYs_pugKWhPDPJcyVWUg04OH3o3HRsUAz1dbNOFEk412iGwZHmUgLAZ46r_o9pmA1
 SWSaur0a23j48V0jWQyVLkpOQSEfB3CRJ.MfVdTHGF6sVho1brRi2jccquehL8C0BlyMHXqYonai
 fNxBpzZGtOCnkuRlzkHRvaySotsT6XFakQhZZFyGUcRkoLGdQWbcQaxkla8_1L4JZsjEZsxO5V0h
 Z8Vre3UNljeAon.i.fASmgSi6WKUfpNX9fQxb8.S24RZQ0PzMAmdCuCSu0UFozpEfdABevuRsq35
 A4i9UlWi2eL2bqUagL74FaJQ1K9A.3fQfD1RARyaVf2D7t3_oYEZuQ_nyGsRagHvcDbF7BvfCJYe
 DxLvx1oGPFHtaT52x5oesJqsVY0mtKjGIGl1MLQwOvu_VlQjyX5fOi3KazKxGJzsdJ0OtqLC9uWk
 VAN_tQe5Lf6gseLBr59xb_3220b6Gw5jfuP1L89QU7eMLaPh8Zp_MptaBvFK.bOjk_ifKOA.9Fb9
 gnwchGiddlp.2LDHLmMmf8ItGIFWQHGwQAIjSoWSPz.sRlthAd9S1Yf.utovT0pq2qQnfS3L9NCD
 LEkbMHu8MaeYxev9zo3weOQfHvH4Pa2w0wFXvEQgUeuXb4QWgSiQoUywAWT0t2qZvaqNicjfwDYM
 5DOlegcB.DKGMZ8Hye.J2N2mkTnRmC8DF2A0Vz9tcpi_LNVqOpziU9GZ6e.LCc8dMBcri7mqANjX
 9d3gdvdJ7WHE-
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic315.consmr.mail.gq1.yahoo.com with HTTP; Mon, 19 Oct 2020 03:43:37 +0000
Received: by smtp418.mail.ir2.yahoo.com (VZM Hermes SMTP Server) with ESMTPA
 ID 48b40ddfd5326160548c2132b7548d2f; 
 Mon, 19 Oct 2020 03:43:33 +0000 (UTC)
Date: Mon, 19 Oct 2020 11:43:26 +0800
To: Huang Jianan <huangjianan@oppo.com>
Subject: Re: =?gbk?B?u9i4tDogW1dJUF0gW1BBVEM=?= =?gbk?Q?H?= 04/12]
 erofs-utils: fuse: adjust larger extent handling
Message-ID: <20201019034325.GB29138@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <20201017051621.7810-1-hsiangkao@aol.com>
 <20201017051621.7810-5-hsiangkao@aol.com>
 <202010191137499960533@oppo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202010191137499960533@oppo.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Mailer: WebService/1.1.16868
 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.aol
 Apache-HttpAsyncClient/4.1.4 (Java/11.0.7)
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
Cc: zhangshiming <zhangshiming@oppo.com>,
 linux-erofs <linux-erofs@lists.ozlabs.org>, guoweichao <guoweichao@oppo.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Jianan,

On Mon, Oct 19, 2020 at 11:37:51AM +0800, Huang Jianan wrote:
> Hi, Gao Xiang,
> Sorry for the format of the previous email.

I've replied the previous email at
https://lore.kernel.org/r/20201019033251.GA29138@hsiangkao-HP-ZHAN-66-Pro-G1

As for the email format, I think you can give a try to use mutt or
Thunderbird (assume your company PC is in MS Windows) , which is
more widely used in open-source communities :)

Thanks,
Gao Xiang

>
