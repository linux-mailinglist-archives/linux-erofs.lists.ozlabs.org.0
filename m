Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 4086821E509
	for <lists+linux-erofs@lfdr.de>; Tue, 14 Jul 2020 03:23:20 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4B5N7T5Lr2zDqS4
	for <lists+linux-erofs@lfdr.de>; Tue, 14 Jul 2020 11:23:17 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1594689797;
	bh=dlWH/cYkw9F1sjDwlOwRYXIHK1NfmvA3lDeTX2kwdU0=;
	h=Date:To:Subject:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=WArAeHECBxn5wYw3X2p9oLQ6yhT4zmyHXTHBmuCEzs+eFoQTshda4/WJQBXs+7tdz
	 Z9poRjkHTzRF9+ki9sstDc4FJFBVeeU7QnxRPv0XNr/0BEV+27IcDGom2aSODkxoJA
	 CAR5GdggDPbYqjqUEf3tJM0XftIZ9mOVXiBta1RKRww7bH7rBIXLp8mKJgdvK0c7Sv
	 2GntMQUzmlQe5vYwvXYbPC5CvvC8aSuL8HeLyVvJqM1EN1U7Xg0Z3OKPduSx+jb2Kk
	 /87bt8XRGRUoySZHP1dVXC2CG1y1FnaXLYettdD/MsuHudq+i/AD0yiDYMxLnKY3Ld
	 QtgpLfKTeVxMA==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.65.31; helo=sonic315-55.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.a=rsa-sha256
 header.s=a2048 header.b=ODio+wTg; dkim-atps=neutral
Received: from sonic315-55.consmr.mail.gq1.yahoo.com
 (sonic315-55.consmr.mail.gq1.yahoo.com [98.137.65.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4B5N7K3D6GzDqLJ
 for <linux-erofs@lists.ozlabs.org>; Tue, 14 Jul 2020 11:23:02 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1594689773; bh=kSZ8A/K3JBp8LhqRTcQFI6Kag9kj97BCjG/6uEWAlZc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Subject;
 b=ODio+wTgG8PN6r2cbOHOkXApXvS1xdIi6NXA4PImpbo92ezGIVt3qYUGr3XfmyJF+yz9QOZC7ctmV8OcDl1V5YodnuMr1ZFW0/rHZZBP33k6tRTFN9Zdzdpe11PIaQcCkGq5Vok7ibIRQqAxVpAxHF7k8qT4VeZduSu2Uam/W/O2J80rNGlI1JO8LwSWXlT2A4e4I0wcJgFX8cOqQlb9dmKvgIxk9BZxMVnKjvvY8LPhpVplhLBpbkqukIDPqUxBwEU0yQZsxf8qjXdA8Zr60JcYF65JxYf1BRA8DB5LoeU/b6ER96lnkGBNDGNBvBrHfJ5BbyGrdydPQ3ODolpAMg==
X-YMail-OSG: .wzDUJ0VM1mceQnxa9_yhOOOke64Dafy9Q9UDbMovPnBzGAmgBzLsOJ7LySXt5a
 9J3R9gX9oe_eAvBUo_B055.hPtrQKHHBimBiKNacZeirx8lMzsr8YJBmlNwgPsIUi3zuoOR8xMEh
 .xD86sEv2WRKPKgvI9IdWwr5suBNFi8ZFZYR_saqcru2b9BpMjZiHPlOhde2PpzD1CkGrkcv_rkT
 qrz2FY29v5MDLxPO7XAw6g5jOSwCJfhNBw4Wr4yavjFgsFbUVpvL9spTDdyjO6fWQOWQSr_sExdv
 xyth76vWEaYH6Ha2VNbOjdnOQzTH3jjgiKc.qx_JeiBSE3OtQA0SUw5CkMzX55wTJEgslA3ZELuU
 I4zajfP7.ITRLJpVvq_SzemDEB6Cx2FTN.6dPlqa_NNfll5opyWdhECoNI06Ba0_X.rIKk000kvb
 1f3v3U39bBgm8c9y4EUs1xlVkoB20_Xyx3rvVgN5h1rh1uPZnLguOLr2.Mia3xZMzJGVBE4tIYzN
 rP5amZ935LW3ov.pGZWs2fNa0BVStIy7nMIChTgC75q1BmlISgtEAT.8Mo5Q.CQ5QRgasnFUr429
 iW4cR9ZoAsAe6OnmF7Lb5.oZ_DXWInpjHSAbC.kiroM4jtSDjvgc8nqP8NuM7KI4BGjQXW121r94
 aGtsjEySM2LoEa2svcNlY.gIhZD7jOWOph4F38tqbre7ORBLhuCyK8S70kneBU6lHYJEVVIhhac.
 1BsZq2oLgZrTAsFLLzLUJsEu_TWxyDyjjrGX4IIz3g2MMeT.g3aqqcpunRXMNxT8Ax5uvG4hg5H0
 RHSXZ5rpdYM.4q077o8GTu2es118G3Duh0JlOcGVWbVj92BoSkWyVaCAzgo9PdwvXSZdgN9aLoVe
 W4CDO319FR_fZx2kSly6a08v9.p8SxbAyE27CDzgyEbeshWIf6goUofcGQ75lHyw.7B7ud4hH3YW
 eAogDELd2AZBbndnSFpF4oj27JCVmSckNAL972OqJceHhf4Zq6uHeo3UtflRq7pPNbhgItHuGN0L
 xj2fNssv4F6BaYMCnENMYwnB_EtpvHz4_m1R7blesOIm02bcdW.EK9nYDkHSjHoNTwCv9pIgZNZy
 kqM0lpLDkoDRZm_s5voyIMhHg065MosNVMU0iVsnqb.DkEngb2duuQTUGwVk.tky2h2EO2Nk1Rjh
 JI_yAxzmiNp2r9mW4E1zXPvGU04r3BXExwVkEO04Yd.ocJ_UQvoYUOnluZR8wGVN8So4jmhWp5cz
 KCr2q8eH9IoHQQF7nS55l572onKVaIgsMCU1I6a8sDf0Zn7DRyqDo0e2y9wH_5U8SqJH9djPq9CB
 XWxnwQO0HSxE1bGZBWCdaNzjzqZq428dy0QBJWplYEkPBMHnAp325Akn6tCdzp_y6_ZqF
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic315.consmr.mail.gq1.yahoo.com with HTTP; Tue, 14 Jul 2020 01:22:53 +0000
Received: by smtp416.mail.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA
 ID ccb2d8946b485b8111546e619c1c7f07; 
 Tue, 14 Jul 2020 01:22:51 +0000 (UTC)
Date: Tue, 14 Jul 2020 09:22:46 +0800
To: "Alexander A. Klimov" <grandmaster@al2klimov.de>
Subject: Re: [PATCH] erofs: Replace HTTP links with HTTPS ones
Message-ID: <20200714012244.GA18418@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <20200713130944.34419-1-grandmaster@al2klimov.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200713130944.34419-1-grandmaster@al2klimov.de>
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
Cc: xiang@kernel.org, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Mon, Jul 13, 2020 at 03:09:44PM +0200, Alexander A. Klimov wrote:
> Rationale:
> Reduces attack surface on kernel devs opening the links for MITM
> as HTTPS traffic is much harder to manipulate.
> 
> Deterministic algorithm:
> For each file:
>   If not .svg:
>     For each line:
>       If doesn't contain `\bxmlns\b`:
>         For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
> 	  If neither `\bgnu\.org/license`, nor `\bmozilla\.org/MPL\b`:
>             If both the HTTP and HTTPS versions
>             return 200 OK and serve the same content:
>               Replace HTTP with HTTPS.
> 
> Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>

Looks good to me,
Reviewed-by: Gao Xiang <hsiangkao@redhat.com>

(Will apply later with other potential patches...)

Thanks,
Gao Xiang
