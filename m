Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id B72519E10DC
	for <lists+linux-erofs@lfdr.de>; Tue,  3 Dec 2024 02:42:46 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Y2Nh35wlWz301f
	for <lists+linux-erofs@lfdr.de>; Tue,  3 Dec 2024 12:42:43 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.111
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1733190162;
	cv=none; b=bJameZE0RmiM4frY8bLg7ywW9niy0HkpC5YhY9pIIfCxT/MLDEO0Rc0R23Wcb7Tgx/F83n3v2VpE8xdA5X0C7yJcQdrwlhgX4XQ0JrcFFOkpMZFDuBNTXfAePFRlOEjDCDz4Td6vUSYRvK6Jy/rE6M/ONbSaxGFc62WR9ESGQ/PI2T5Po98g0x0yv59bKvhRqPqZ9WVyRF55AIE8vYJgg9lDOcrLsYyVxAJPpl4Lx2lQrHqYGqMzuoaV7CIsWOoUz68NL4DO5iKGlnuXMnENZgD/ObMP9sQXZyY8+LOmiqbnOCxgfXBjcFXGIc0BDbRDC1dXhsXPcLoQnsZFXkSRZA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1733190162; c=relaxed/relaxed;
	bh=uTUj5YMURf+KKG8f/1Sz+bcXu3/nl4aaFLZoInHn6Y8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Np71d8TcqQd8E33zKieafU+GUJItmc5n5r6M5Y6mMxlJzFW4vwWKxP4AFBk5AupoD6JvZVz40g8yZ6v1QKHC18l9MXY9PVIDUKXxnvgWnvJpKaM2XXLl1mwLKFyRJtT41dMLQ5Hiz9n1f9WqJc0DtgBWcucKGNsvej1SrovKYRPEQaqtlCLsaxMVql+7D9p7N5h4Eo+hfv+gyNbcCHUMZbkZL73RQLzavQW1lbi1vgY0uZNzDdNxwMoxtEkfokkv5OGLUGJy9PaoG1oMfOF5HUbAFbwpWWf6MeRPaeMswiEOvprAfSkpAG11NOuc07WdwCAgOM81UhXZto+20dS+2g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Y4V0VGNH; dkim-atps=neutral; spf=pass (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Y4V0VGNH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Y2Nh03bN5z2xk7
	for <linux-erofs@lists.ozlabs.org>; Tue,  3 Dec 2024 12:42:40 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1733190156; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=uTUj5YMURf+KKG8f/1Sz+bcXu3/nl4aaFLZoInHn6Y8=;
	b=Y4V0VGNHi1bDhqv6Zjuwkxdr4Y8UVZj9VIhfROr2BPb4ced6GzHdDmr/pAVkK78TSL2hzeJ2jnnzxriRjxI8ZE5RRdJ7gTApGjvB7e+tjxvplkHhK0RIQ/c9vLP4+Ojeu7Jdcy5AbL3yTPxD/hOPZhdZ4SnBzY3BVEGl3J+0xDc=
Received: from 30.221.129.129(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WKknLlN_1733190154 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 03 Dec 2024 09:42:34 +0800
Message-ID: <b68945e3-3498-4068-b119-93f9e5aaf3ad@linux.alibaba.com>
Date: Tue, 3 Dec 2024 09:42:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs: fix PSI memstall accounting
To: Sandeep Dhavale <dhavale@google.com>,
 Max Kellermann <max.kellermann@ionos.com>
References: <20241127085236.3538334-1-hsiangkao@linux.alibaba.com>
 <CAB=BE-RVudjkHsuff5Tmg2sumjDkPKpQ9Y0XN2gZzPFxUGa+hg@mail.gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <CAB=BE-RVudjkHsuff5Tmg2sumjDkPKpQ9Y0XN2gZzPFxUGa+hg@mail.gmail.com>
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
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Sandeep,

On 2024/12/3 05:52, Sandeep Dhavale wrote:
> Looks good,
> 
> Reviewed-by: Sandeep Dhavale <dhavale@google.com>

Thanks for the review!  Max Kellermann reported the similar
issue can still be reproduced with this patch although I'm
not sure if it's the same issue though.


Hi Max,
I think at least this patch resolves a recent regression,
I guess we'd better to address it first.

As for your reports, I think we might need more information
about this, since I don't find more clues from the EROFS
codebase itself.

Thanks,
Gao Xiang

> 
> Thanks,
> Sandeep.

