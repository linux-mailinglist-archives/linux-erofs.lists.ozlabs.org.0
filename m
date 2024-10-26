Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id A89CD9B1400
	for <lists+linux-erofs@lfdr.de>; Sat, 26 Oct 2024 03:26:55 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Xb27F0gkYz3bcS
	for <lists+linux-erofs@lfdr.de>; Sat, 26 Oct 2024 12:26:49 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.113
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1729906007;
	cv=none; b=Hoo1jtG2IX+IeNAjLtOoRzHXAXPcXujBdXM4EDh5NdhPxp8f1+HpMOl6fnZnAkh677syuk0nFKqDDwGCaOlq6jADoMyMjk+wwFT6dMeEjWSAn3+c8Ha5QzOQtGHiOxCVPqUrLFNkZ0KM4KOogg6J8S4yRCS1H5RdOF2d5S9gPzbMxV8caMgYL8UJpLjKWIc1y0S7Txd+fvLp3A5fGxux5aodM8oJ6qgHdwipNGRBfiMqSzv1xcUE/jUYPihZr3LFz0Qo3/jt3/IfeZQmLUb4iMqwjvBeCQlZ2pY3+Oio+SsBQGfLfLspBUirVD1orhHGU5Mn12ZzAcm0XfGmN+SnPw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1729906007; c=relaxed/relaxed;
	bh=3kRCZ5zqXWFsH4KEFntlyCdYuSAtNjhYUqL4moe7T9I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TRm6w+7Q8USYLL7CSqkvwYaL1e3Lkj+ykf3lTMzNlDXP0Wey1qpsn5GMTWWS21RUa9fx58DyKD+MLvD2kXU15ax7zUb7+HWnDMA0VrYwvCa3iDUZoCA4X4/cafsvhRuJtVuIDV/m6vNWUndOh1k/vkk8BXhP8FUVlrZf4+eO5+GhegWYEEYM4eYQuJrTV1J0l1G0VVrAP4mbhWkPprtcSXFAZ/gvWQrUmKIvMxewUwQ2l20kib+/8dljApjFZv+o0JcySjOVTW9rXgWUKEjDi7ZVlWG01VAo1XMSHPf4eYjKR/NPqZXpkdnWQ6s0s92rSUaXMXhWDr1vZM2mFnRFWw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=jrtqDOdx; dkim-atps=neutral; spf=pass (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=jrtqDOdx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Xb2761dFTz2y8Z
	for <linux-erofs@lists.ozlabs.org>; Sat, 26 Oct 2024 12:26:33 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1729905988; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=3kRCZ5zqXWFsH4KEFntlyCdYuSAtNjhYUqL4moe7T9I=;
	b=jrtqDOdxGi5sukHfhkAMdu96Rkamn+d/omQ0TSbIc/SGSGtj4QCzN/WnAgT0GWhmkNIO70SgjbFUU+xKhBirydXnX7H1q3nEmJFd9u1CAUsw++j9z0XD1jqfZX1ky6tDxm7Fs9xBsFihIl5YS5YwconeNkcaHPovEyD8wwfdsvA=
Received: from 30.27.69.130(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WHtjA1Y_1729905985 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 26 Oct 2024 09:26:26 +0800
Message-ID: <cbd72466-72d1-4112-a918-23d57e0a9a17@linux.alibaba.com>
Date: Sat, 26 Oct 2024 09:26:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] erofs-utils: avoid allocating large arrays on the
 stack
To: Sandeep Dhavale <dhavale@google.com>,
 Jianan Huang <huangjianan@xiaomi.com>
References: <20241025015246.649209-1-huangjianan@xiaomi.com>
 <CAB=BE-R4MuyEw2VYM3jgMWQeBdSOKTLcV1XXDvfQ+LPJb-YG7w@mail.gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <CAB=BE-R4MuyEw2VYM3jgMWQeBdSOKTLcV1XXDvfQ+LPJb-YG7w@mail.gmail.com>
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
Cc: zhaoyifan@sjtu.edu.cn, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2024/10/26 01:41, Sandeep Dhavale via Linux-erofs wrote:
> Looks good to me.
> 
> Reviewed-by: Sandeep Dhavale <dhavale@google.com>

LGTM too.  Sorry for late reply since I'm still on my personal
busniess these weeks, so it might be delayed.

I will apply later.

Thanks,
Gao Xiang

> 
> Thanks,
> Sandeep.

