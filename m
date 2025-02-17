Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id D6E67A37ED2
	for <lists+linux-erofs@lfdr.de>; Mon, 17 Feb 2025 10:40:18 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YxHh0332fz30TS
	for <lists+linux-erofs@lfdr.de>; Mon, 17 Feb 2025 20:40:16 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.118
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1739785215;
	cv=none; b=Uk6VlQIVVvivW5S3J8DaaidmwIMXxleWBs9oGrTaqURQiqOqtzKzVQ6VvVYDaa6UYsIMAR2gi2QXff+qbXnPkm3rzTs2gApdYR0Auu8OYPaG1DhG+AJZ8xPvLjivyV8kk6itQdCAeDjEWfOswN1LkY9Y8tsHRpSXf5Z2bZ4Zyk855/5/aivcqHd5J/iBY5Iok6gWjJYCV/ZvGO9XEYEAmY4b28LFlCe63afw2gk1EmCGcw20YVDgJhRZyCOxkLr2OOJr8oe43cTZHIt2RUPO5JECQ8y/jB3POzdeKHRs4il6gH7gTmuUBs5IzqRpg7EkkuG4LRqBmJtpgVZvbBuR/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1739785215; c=relaxed/relaxed;
	bh=87ftoKEGoH60vQ0eFrijNwZZZFS9ia8YwyKFg83RPJE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BIu1hsQK55kbudbFDyP4fJfyvW9CC/oN3nUQ/qvKHAJ2vFTi3PDU9ibY0y+1gBhmI5vxCB4UbQ/7HNtSHPlmtlMqTDf7evQBtcC5lw+1H1tAYKBm8n2ybh3NRMblssp2Q/C9vbW4Iyu1XtWTIXCci+oaFWJLIopbM402zvnDmKjf6dJ8sKD6+9odTzQkeyX32Mm/qshhvRfOMYYgd3H2DwV1Ca+fJ9ZbEJKXNWoHSYUYbXw4c4xBdHk2bvtMVQkRaHTKav+c9m+MfK37Jxh92XtPY6WKM+txxON85ABXCmQKhMKCFFZr9g8wO+mC23q0WI3je2gRBvuUtUwgPNG9Hg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Anm3tU2l; dkim-atps=neutral; spf=pass (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Anm3tU2l;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YxHgx5cxJz3093
	for <linux-erofs@lists.ozlabs.org>; Mon, 17 Feb 2025 20:40:12 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1739785209; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=87ftoKEGoH60vQ0eFrijNwZZZFS9ia8YwyKFg83RPJE=;
	b=Anm3tU2lMwm/Tqc06Nnw/rC4n3Ke/9TUdFZkP5afWoxcxhZ0VQ/Tifpbx89xE6BFFt8QnYMU2FevfqWfMfOc+d3nIsdw8n8PJK2gjXpFEBmSZDq3ZvAvrLl/+rWmm4maAAUiJczp81ryDDc4lwzc16+nmjH3hHaR4ZP09ukhLZE=
Received: from 30.74.130.36(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WPdVKol_1739785207 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 17 Feb 2025 17:40:08 +0800
Message-ID: <b43f712b-8f22-4454-ac86-1347016e9f52@linux.alibaba.com>
Date: Mon, 17 Feb 2025 17:40:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v2] erofs: get rid of erofs_kmap_type
To: Bo Liu <liubo03@inspur.com>, xiang@kernel.org, chao@kernel.org
References: <20250217093141.2659-1-liubo03@inspur.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20250217093141.2659-1-liubo03@inspur.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
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
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2025/2/17 17:31, Bo Liu wrote:
> Since EROFS_KMAP_ATOMIC is no longer valid, get rid of erofs_kmap_type too.
> 
> Signed-off-by: Bo Liu <liubo03@inspur.com>

The subject should be `[PATCH v2]`, but no need to resend one.

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang
