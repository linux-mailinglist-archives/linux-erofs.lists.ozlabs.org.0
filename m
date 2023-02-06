Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id BB9C968B411
	for <lists+linux-erofs@lfdr.de>; Mon,  6 Feb 2023 03:08:44 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4P98nQ4SFsz3cGy
	for <lists+linux-erofs@lfdr.de>; Mon,  6 Feb 2023 13:08:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=oaufHGaM;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62f; helo=mail-pl1-x62f.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=oaufHGaM;
	dkim-atps=neutral
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4P98nH0FGrz30RJ
	for <linux-erofs@lists.ozlabs.org>; Mon,  6 Feb 2023 13:08:32 +1100 (AEDT)
Received: by mail-pl1-x62f.google.com with SMTP id m13so10636610plx.13
        for <linux-erofs@lists.ozlabs.org>; Sun, 05 Feb 2023 18:08:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wFA+qqcHIsxmmy2Bs+0XDIcvd3GUt4Oi3ikg3og5iTc=;
        b=oaufHGaMM86Zvit/UMGFQnzGcbvKOqGaTZZHpe8Fl41Dt0SgTv+80Hzwr82Ktwhg+e
         g4zOy7FXojHZOAMeZ9I8hDGetp4JsqmRURNrKRjBIxEbHY0ndl+MhpLiKyYZ3dDqNG7k
         jLe00ILbaebrDcgbMWn8oCJq3sQwVgDRAhPnn2GJWB1nENOavCk1sf8rKRh9TnArwZyZ
         LBjaf8Kj1MjueViKIiut5N9IfIDSrJSIzBAgaYD/+ywS7ESRrg5QF6iVd6EFksMIbYYR
         YBRORj69tZ4ZYKRuELZ0pIMgzzLICQMIh/iWRyjHMfR9/ev8/FyD2AeUgl4S8v6cP0aI
         1DhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wFA+qqcHIsxmmy2Bs+0XDIcvd3GUt4Oi3ikg3og5iTc=;
        b=WhQ5Wrr5l8C5+gDUv6pS8RdIdjL4cdrHuz71IcU/C6lBygQKRNT6c9INyZGllpWCTe
         ROGIf7IQm8O8KuBWJKYNxpnmwB7TRDyldV8lpKy/jZEmi2CCpj7veprRf6OREW3jmBQb
         AsgV2iUoAhrR9SqIYYknlZ1u6b7qiXzADUAGhXbT9BKfvXrq6cYJmV8gJXFgM3yRRHen
         NvulBHqFI4cYMP8l3InBZO0T6ThrMuf/dYh0T+EipIvPFaviZGI2faaSy3jxwJ1urbjl
         YkfjLIgWgE+w9aaFghP+SiGnrTEKNC/0WvrMtcI+rDgPawTXh8QKHfpX+7Fjwv1UIgi9
         wCCw==
X-Gm-Message-State: AO0yUKWhQqqUjA3UKbFWPXC2zAUW8/9ZiFsAn86kq1ZMgllT8y/Gldln
	Mj0co0Yr3rC7o1FXNu2iDXk=
X-Google-Smtp-Source: AK7set+5L6igrBTSO/bj398d0D2R/rCfgx2P4xjp2jztXRfKjjAEIcdDyrQeBw/9lzvS3R3llKha9w==
X-Received: by 2002:a17:903:1212:b0:197:35fc:6a5d with SMTP id l18-20020a170903121200b0019735fc6a5dmr22443583plh.30.1675649309981;
        Sun, 05 Feb 2023 18:08:29 -0800 (PST)
Received: from localhost ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id f5-20020a633805000000b004f22f5297bcsm4930231pga.67.2023.02.05.18.08.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 05 Feb 2023 18:08:29 -0800 (PST)
Date: Mon, 6 Feb 2023 10:14:10 +0800
From: Yue Hu <zbestahu@gmail.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [PATCH 4/6] erofs: move zdata.h into zdata.c
Message-ID: <20230206101410.00006187.zbestahu@gmail.com>
In-Reply-To: <20230204093040.97967-4-hsiangkao@linux.alibaba.com>
References: <20230204093040.97967-1-hsiangkao@linux.alibaba.com>
	<20230204093040.97967-4-hsiangkao@linux.alibaba.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>, huyue2@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Sat,  4 Feb 2023 17:30:38 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> Definitions in zdata.h are only used in zdata.c and for internal
> use only.  No logic changes.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Yue Hu <huyue2@coolpad.com>

