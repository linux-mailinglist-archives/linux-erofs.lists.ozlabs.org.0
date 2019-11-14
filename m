Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CD98FBD03
	for <lists+linux-erofs@lfdr.de>; Thu, 14 Nov 2019 01:27:20 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47D2P20xK5zF6db
	for <lists+linux-erofs@lfdr.de>; Thu, 14 Nov 2019 11:27:18 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1573691238;
	bh=ei1qHsn2k7AicbqvMpWAp4wSMZUtTC57NepsVOZmn9M=;
	h=Date:To:Subject:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=MV2sz1gsLnyuSukNpoITz0cTo86rc8dOKuBW8gd174NfyMPESjCvJpRETTY1WdYx/
	 8L+1nsjzEBq00Y7Er4EFgF/mWrjL8N081CWCBJ3vQ5Di0IDs4ni4+ArTdE3c4xYjiF
	 EsWJyMLa/bL3FOjYAdsgq2YN/WIT1R9TejcIXytEbFYgvnOeoc3aStz1UzmkGJWvEa
	 jMy+WPJlAX79tHOXiRwY0Ny3yHdCLfG1f99i7zpmHb2tkqUPOv8lBlRTvzsjgkwYjC
	 FwVmUwHG4kCoSPkt0wGLxLdh20ybnDbGd4KgGzqA4gbj4+nqIc339Bf3jNhqHvHcZm
	 IqUSGYz2/e4Ow==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.69.206; helo=sonic312-25.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.b="rzSABC4Q"; 
 dkim-atps=neutral
Received: from sonic312-25.consmr.mail.gq1.yahoo.com
 (sonic312-25.consmr.mail.gq1.yahoo.com [98.137.69.206])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47D2Nr4SZZzF6gM
 for <linux-erofs@lists.ozlabs.org>; Thu, 14 Nov 2019 11:27:08 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1573691225; bh=SrYNaF0hIMUsxMcr9Dpo8/YVWMDR/I9St5RSMFPI3BA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Subject;
 b=rzSABC4QumJHZdMAVIrFET9mn/x/vK/e5HM52labuD+WkKW7NNAhb3RPBLI+cthyry28MM4odejHI8fsI8CTTIx147wv0S0OtfF4qQaMck+SIeGY73F5g485wFBSm9jbG4B6KUpZv4e00jV7XWvCLwNNjhckZ+y/weIHryISfa1SM3rJxgY0cDXV2rF/fIx3Z/5CaJT1Eyrvaq9cQCN7otsouBHcteGztzsp3ymb9A/yK+PdZtOxdTNTDM90CoUPUt9DkERhbxNz4CB6xS/LP2yCRPzFF+RUhZuUD9kt+A9W3/b24Pp9ZgpjI9FKzyPndAlD+QgoFwphjBf6ba+UFA==
X-YMail-OSG: ZbytogEVM1nQmYXUELIVunc8BoBracoqQCi_P5dusEZCWQSXKqDvF4GswY76X5i
 aEmj8wKl_aoPiYzibCY8YPSICt36CZl2AjWC_OpagLv49gD3y.rywnEEBNNTX75xbGUx.zUM645d
 jl2iKhpXVfr1RrJNBOgRraw3N1tKrrMCeQCgnR03C7hkTi5Ru2hiSlL796MO.4DYaPaW82rV373z
 fNMGRQ0U_n8pnTz4wbp2mt6GmJewucXsnF2AcgMHNpKV5cWG_6QqaSSMEdcL2uB4E2C0FcFm7sSF
 9jSVHAx8PXoMA6hCAJRVk77gDCpkrIUilopuAeSga4ro._HMBld4t5dzXcigbcE2HBTD7lzFKOq4
 .tMQ1LUtIlieW5sd5mQxZR2wsKcTKmBBoOTnJt5FQrGQHdaM7LMQNfsBo8q_I19N9KbHKKt.tbIo
 JzOGPFb9v24qM.1gYKRmOKllKou8TUFKNDOp8z7oGht7UhEvxePj7vMKD83V23BGJA2YPmXOYpxJ
 OPTMUTPRgD65JwU0qmKnPKav9bhHM3FDjz2shY3_zB7Gmhcm3ZSVMFc90WxXHaoIVVNpr99U7FEM
 9NW9npaMe1E5HvWGWisVwb1AWBjeLlwW24lUEXlKScRsVNLjcgIgoq1_IFNf9ZnjZpKjvsnqiKg.
 xs2.4km5ic6k3ncw5u9vfpyiItGt8V0ULKqNZCahx45bdLQFGjygOb7eIDM1gHJ5oegfj0rjgust
 T9AkI5iWN79.u5uBTvASKqaYgenI7DPkzgn2ZBjilYoQoQIDlCxQ3ek_FjpN3.uuVgIFgF2fAmMT
 Am_ILG8XXvV8WmMYmogzq.RzxIRBe9EdCBI4CgSNMYRzPI.djDn._rYfA60LvhLM_jXVoG24qwyb
 yZvf6wMt..W2.YKvDz0dO0q4CgRTAQz0i7_MuKnXU91rcJq0yzkiUdFemQFHDwR1bpHnIfj5DtKV
 j.h6VUpppq.YIHYbU5aneuExfPBBWJOlnEayhWkNkXSvki76C5ZwejVRJQnYrDa50_zn3OXTskfU
 7Qm5So1RgeNgbownvrcYysfqLFBOIKZpYMwFLUYNWNIrfW4etrpBEVp6Ko_Xw3xk66589x.Ip8e9
 JkbO2knsRhLmAHavcf1E6SrFaGfSLeT.TaLeU3v1EaHHHkMheGbLrDqXNs2RqKjPDKP3zf6Pl0gA
 4BWnj3a88YFQuOq590fPq5WmvuT_pfEoHeheZ.bDemdF2ecm1wT3CFDqJZov0e61RC6xelpY7jjk
 xfMWAYMMrUMbPXIeD6a5bRv_vwpml5sxFINlFaPHRBDGCAwuEVxCpVAH1NXVi3C.PecyKgiiMFje
 y1ZLZCINTbaWvGWcmHtF7TsvvJ4Dg5feDiWD8qPOCXk1Kdex28ht1tpKeXXpWG636DA9tr_r.ve3
 GK1UN
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic312.consmr.mail.gq1.yahoo.com with HTTP; Thu, 14 Nov 2019 00:27:05 +0000
Received: by smtp404.mail.ir2.yahoo.com (Oath Hermes SMTP Server) with ESMTPA
 ID 5cb2e9d9bb63f81f527ae8a58f207b7c; 
 Thu, 14 Nov 2019 00:27:01 +0000 (UTC)
Date: Thu, 14 Nov 2019 08:26:54 +0800
To: Li Guifu <blucerlee@gmail.com>
Subject: Re: [PATCH 2/2] erofs-utils: set up all compiler/linker variables
 independently
Message-ID: <20191114002651.GB2809@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <20191112112650.143498-1-gaoxiang25@huawei.com>
 <20191112112650.143498-2-gaoxiang25@huawei.com>
 <f38afa9b-7a81-d952-bc44-7c6c89aa477a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f38afa9b-7a81-d952-bc44-7c6c89aa477a@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
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
Cc: linux-erofs@lists.ozlabs.org, Miao Xie <miaoxie@huawei.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Guifu,

On Thu, Nov 14, 2019 at 01:12:26AM +0800, Li Guifu wrote:
> Gao Xiang
> 	Can you resend this patch ? It is conflict with uuid.
> 	uuid patch :
> 	https://lore.kernel.org/linux-erofs/d4d8127a-c452-f7d4-b3b1-50098cf07e12@gmail.com/T/#u

You're right. I'll sort out all erofs-utils pending patches,
rebase this patch and resend soon.

Thanks,
Gao Xiang

> 
> On 2019/11/12 19:26, Gao Xiang wrote:
> > Otherwise, the following checking will be effected
> > and it can cause unexpected behavior on configuring.
> > 
> > Founded by the upcoming XZ algorithm patches.
> > 
> > Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
> > ---
