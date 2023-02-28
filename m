Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 42CCC6A526E
	for <lists+linux-erofs@lfdr.de>; Tue, 28 Feb 2023 05:48:12 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PQlHD1Lz4z3c9r
	for <lists+linux-erofs@lfdr.de>; Tue, 28 Feb 2023 15:48:08 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1677559688;
	bh=K8WrLUHrOkZwVtvZ+lvnGv80l/swT3uPg3ZR+9WAcCI=;
	h=References:In-Reply-To:Date:Subject:To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=DtwtVqD5g1R6ZB8U285o3Inuc8YfVkrZ9W53Y+xOPX7S5MlYyP15T1tGx1Zfq/bzn
	 j3hYanLb9vZulAUWdlA2NGaEsNOX25nryfeLibbM8FaGmhc+1SGZzAnwlqUu3Z2Uvy
	 JNTUDEeXwqn7GRAu2uaHAQaBfB4IE5WLs1Olu0ZnaWzApIyL5aTRs/rcNYnomL+8EA
	 Vy53Miy3Z4nj5Uye5SD+d/R6Tc6UhznYn//bR5UDe884ql6wImx3gspMvPBD+NLLEa
	 BtRE1whxCm1Hw0Y8N8Oc33pRuZ/HdmeR+MIgCaXEgQRAQlpyLUJQ6n5P6pAZqPsf5I
	 G326U3re5Qdbw==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2001:4860:4864:20::29; helo=mail-oa1-x29.google.com; envelope-from=dhavale@google.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20210112 header.b=oBCwEc4d;
	dkim-atps=neutral
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PQlH91Sxjz2yWN
	for <linux-erofs@lists.ozlabs.org>; Tue, 28 Feb 2023 15:48:03 +1100 (AEDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-17227cba608so9798514fac.3
        for <linux-erofs@lists.ozlabs.org>; Mon, 27 Feb 2023 20:48:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677559680;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K8WrLUHrOkZwVtvZ+lvnGv80l/swT3uPg3ZR+9WAcCI=;
        b=YiNecuHDbPJU1ENxnwRabGkoq2AOXbwKtQoYdb4Dau1gxxPmbqmLZA6D/0Iqub3bA9
         qiQWoQVXKZ/YCwaqGVItJSea5EpTU5uyaAWlNY3/9raRhi9NktA15xkMVrHsaOu95dEm
         bCbRAiYjMLVLLoo61kmzWvbDfHCwbbH/kXeK+V2eo1+40xiXqdOsvRKVceAKD6JzBEDm
         7pgfPiMdWsmUYFlnPgz+xZcYnoLvnKJpDBb24abX7hIX76gDKQZHm/XmqAl5+bFVJvmE
         nuvP2QmXRxUL8vY/7lPFkRdiCPpfEV56agMtrp+ZJMWZnmWlEnZ3grKPhQQPCn13qgg6
         /PtA==
X-Gm-Message-State: AO0yUKVF+arTsgxoXMo6ipNVMzLJ2C6OxrfkW8V8X2U/ayPSSgD0rM9l
	/LvkXaay9myIrcKiZqDCn6Kt8DhlMIs2dNVPop2LTQ==
X-Google-Smtp-Source: AK7set9JwUW2YQ7DpFFt31o8JbaZ+IMzObGX/ZQoBxVB4MK0wJoMnkEmUQMsMFY4Ai/Diyc3/c5VzK7fzYBls1tfzX0=
X-Received: by 2002:a05:6870:98aa:b0:16e:93b3:2059 with SMTP id
 eg42-20020a05687098aa00b0016e93b32059mr243150oab.9.1677559679935; Mon, 27 Feb
 2023 20:47:59 -0800 (PST)
MIME-Version: 1.0
References: <20230208093322.75816-1-hsiangkao@linux.alibaba.com>
 <Y/ewpGQkpWvOf7qh@gmail.com> <ca1e604a-92ba-023b-8896-dcad9413081d@linux.alibaba.com>
 <8e067230-ce1b-1c75-0c23-87b926357f96@linux.alibaba.com> <CAB=BE-SQZA7gETEvxnHmy0FDQ182fUSRoa0bJBNouN33SFx3hQ@mail.gmail.com>
In-Reply-To: <CAB=BE-SQZA7gETEvxnHmy0FDQ182fUSRoa0bJBNouN33SFx3hQ@mail.gmail.com>
Date: Mon, 27 Feb 2023 20:47:48 -0800
Message-ID: <CAB=BE-Svf7TMPs-eA+sVuGtYjVWfKd1Nd_AkA9im4Op7TCLW3g@mail.gmail.com>
Subject: Re: [PATCH v5] erofs: add per-cpu threads for decompression as an option
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
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
From: Sandeep Dhavale via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Sandeep Dhavale <dhavale@google.com>
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>, Nathan Huckleberry <nhuck@google.com>, Yue Hu <huyue2@coolpad.com>, kernel-team@android.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi all,
I completed the tests and the results are consistent with
our previous observation. We can see that removing WQ_UNBOUND
helps but the scheduling latency by using high priority per cpu
kthreads is even lower. Below is the table.

|---------------------+-------+-------+------+-------|
| Table               | avg   | med   | min  | max   |
|---------------------+-------+-------+------+-------|
| Default erofs       | 19323 | 19758 | 3986 | 35051 |
|---------------------+-------+-------+------+-------|
| !WQ_UNBOUND         | 11202 | 10798 | 3493 | 19822 |
|---------------------+-------+-------+------+-------|
| hipri pcpu kthreads | 7182  | 7017  | 2463 | 12300 |
|---------------------+-------+-------+------+-------|


Thanks,
Sandeep.
