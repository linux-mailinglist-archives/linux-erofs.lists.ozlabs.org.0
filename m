Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C090E28F545
	for <lists+linux-erofs@lfdr.de>; Thu, 15 Oct 2020 16:52:37 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CBshL6RjrzDqQn
	for <lists+linux-erofs@lfdr.de>; Fri, 16 Oct 2020 01:52:34 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1602773554;
	bh=YeWq5fZIGLtp4/rn18YcVJcHlb1BGqXeeNrjpFe23Kk=;
	h=Date:To:Subject:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=FUPG8o1jTJB9kvksHlF3rYZCfZw2gN6ESLBwRLqn004VL5UzvH9jv9hak69Qx2CNQ
	 Nd3+IphpIxRZS80LF0Avr/NFDFTIkIoTxGy/SAsiqSGtYYy9eR3/wqsrxDBnB7Y8Qb
	 bIcTfy/bRdlgrbnAqVx/MDhLZ28O4qCKgVPEksm7dAq0OdYoe7AVZJLRFT8TTxr8DB
	 stIWBmk5otjvSnobOhPZIopqr/2xrPzpvHasItFGfmrVjBhcS5VGki7K8lTQvC6I2F
	 VZyX3FQhrywlZD5y89Br83JA2mZare/I76VDdjxd1T4g4xEuce/cOluyHLsIs1/sTt
	 2iR1H5VZ1xhmg==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.69.204; helo=sonic312-23.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.a=rsa-sha256
 header.s=a2048 header.b=Jt2k7cNU; dkim-atps=neutral
Received: from sonic312-23.consmr.mail.gq1.yahoo.com
 (sonic312-23.consmr.mail.gq1.yahoo.com [98.137.69.204])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CBsh91tvdzDqC5
 for <linux-erofs@lists.ozlabs.org>; Fri, 16 Oct 2020 01:52:22 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1602773536; bh=8WZha/vI22xHShlcMPQfPW3rVGDW1CMbP1/3THNfCmM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Subject;
 b=Jt2k7cNUf2LLmlSlwu0B3v0Z0sZxf4ZJ/9T7So2/p0LgdUlgre3I6RU0h2jqOumuG01FV6hPE0LK1pBBdTUbaf7vE66uHkH8/dQYRN3XI1yH0VmeM5N3ybeJ6j2PwlYJIN1/Nk8IQujxEASHozdUeTAwLPphhvNBzVbBkFTWT8F4EG//sxUqngusFj6eNNv7O7LMcxw4qpLFJlhomFmuMXuZXRnuJuE0zFblqzuF47Bjbnttr6mPnb2oijHdxh5omUkcR4XJ+QrB6Jv3KYvNUwCgc2L38jX/gITUnXc0ZBPVcqMPwKTETVvzFQ/TdNsCXdg+FdkaxUmOUorGsKfS0Q==
X-YMail-OSG: 1VHmwBQVM1nCqD_1sZ_Hq9rOVO2KuMJt_97vc0BeqeXXQD3kemoUr5_IGpkvPEe
 QB.xaULGPDi2w7Br08VcDem4tT_K1x7kiwOTyjja96krQnjPcEb2j.IlJo0_Tb1Dp5fV23GPVflb
 _6VZo2vQh_VGW4JyRu_z_YqadF3VaqfhemQKsMO1gAbhlqGP0nqMuQ8bgvuatp9IHjuApnXWzUFT
 Vi3cqyii.5AJQnlOnInutDsduhUctwNA.VL7LcUHJQkKBC9T1XZaCL.1mE5HmYljs3vgg8fLz8SD
 eC5736zsAmD..ConMFm13RZrmACnrq66iYqZxOxFJFRymCcepHR_pudPm_hp6fRgWDlcxfXQMIOH
 JpNRej5ovd.jQs6m4_nIOtPogF4kgYBloELiPnTj8K4lewQleAATbUZenMtFGqYuJHgkoav8w.A5
 HNuX_Nz3SCOOCjPiiwJWl00pm9dJ9_HfATGoXpmuNz6iuKw4suV.nWYE262SByu0zbb4K9JAX3Mz
 X8p2KT.AnKJT8PP.TKShdUsw6vG5xSRzQF7VeJBMVVOg3TtHlRqtf3ETBefK_SDu7_xBezuF.Kj1
 R_Lmt8lPv0bk6of7Obw9yNE6Zm8JLh9A9gJzWOa9yIsvc3CuStKOkyY5rEz5XMNTThtNElJrpjAg
 npj.ca4q2JFg6ElknM02iHfGxzcuARtHOB3AnPkIfnEQkjYyiPwJ92zVoPq9vNDSZiI95cYy11wL
 Y3RBhT3CZq12atZo_eQYia2qXGdzugZTfwMXr3vSC6z9wADAmNkZL2ki.RfKXJLJPYq0XiQcrqby
 HSXocODSlNoQUUj8QX4JBeTmFASq2kRxgoST7fGpyefmNd.DtfE4PYmD7GYkhPOAAxOHERBypqwv
 p9SBFCXzDvHuDP99RlbCYjEBqd8SCP1TtID0ZabDs6R9yVZmRgdS35UsfAtGqABKWmoi6K3SqS13
 NW5m9_p9RK8v77iYv_CEqeVxNO8NdP8CFof0.ddWqfDucS1I2YT0i9ZQrUXoh1uzy_YZV_mzAUyI
 LTxc22wdiO0bbdS7h8IsY3vx03YT0uZX9OusOHDskAtyMURNh8nI3U6s0d0wqGWhghqPm1380baN
 KA0tbLJfLxvZT5Ec.M52LrsN_SgeWnl0Wc5pDSL6OObT1EkWYwrviPpXJPC4wKrJ2qvm2HZ.4Etj
 17xAnGpOmua91SnUT0FwvtGjYvdBS0TfFevKNqT38OOoMVnp3utw0YZa7ERBX23bFGjtzWnEeEqW
 R7qcdqtNKh7S4HTVWM5BCp9eeeQU_Df5Z91i2BL6GVIT3bkNzCidOF7eOZbKK8mp1VFz.QzBmwur
 2Zg5ZzX.6U2mkpFlQ1iUYGLkBY9gN36Gez4SN9BVly1IPMMCaJbY5jLxlAg39X2z2I_E8awVYZ66
 MRhC.G0qRMi6lUegIZcixvzKFmxKYJ.FJqMvfocRgX..sW1v71QkB0TA_iJBUZTDbDhiP2n48m.d
 1GG.zH_7GDEyMVtFmQ.ll3GXqFNauiob9IyT8gjRhtkPmuxZU3uRFzOtIL5fRAycnlajLj5oHnor
 a2pOaSkRaqDg-
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic312.consmr.mail.gq1.yahoo.com with HTTP; Thu, 15 Oct 2020 14:52:16 +0000
Received: by smtp414.mail.ir2.yahoo.com (VZM Hermes SMTP Server) with ESMTPA
 ID 34bd3a153be79c463a50e13f576dbc80; 
 Thu, 15 Oct 2020 14:52:09 +0000 (UTC)
Date: Thu, 15 Oct 2020 22:51:58 +0800
To: Huang Jianan <huangjianan@oppo.com>
Subject: Re: [PATCH 0/5] erofs-utils: support read special file and
 compressed file for fuse framework
Message-ID: <20201015145147.GA20107@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <20201015133741.60943-1-huangjianan@oppo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201015133741.60943-1-huangjianan@oppo.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Mailer: WebService/1.1.16845
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
Cc: guoweichao@oppo.com, linux-erofs@lists.ozlabs.org, zhangshiming@oppo.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Jianan,

On Thu, Oct 15, 2020 at 09:37:41PM +0800, Huang Jianan wrote:
> Fix some bugs in directory tree parsing.
> Support read special file and compressed file now.
> 
> Huang Jianan (5):
>   erofs-utils: fix the conflict with the master branch
>   erofs-utils: fix the wrong name length of tail file in the directory
>   erofs-utils: fix the wrong address of inline dir content.
>   erofs-utils: support read special file
>   erofs-utils: support read compressed file

Nice job, thanks! I think we definitely need to merge erofsfuse
for erofs-utils v1.2. Therefore all new upcoming features can
have a simple way to verify its on-disk implementation with
erofsfuse first and then think about a more performance-optimized
way for kernel.

Let me play for a while this weekend! And wonder if Guifu could
also look into that as well.

Thanks,
Gao Xiang

