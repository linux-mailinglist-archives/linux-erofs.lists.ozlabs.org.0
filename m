Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 462989F0142
	for <lists+linux-erofs@lfdr.de>; Fri, 13 Dec 2024 01:50:20 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Y8W2y06Jfz30hW
	for <lists+linux-erofs@lfdr.de>; Fri, 13 Dec 2024 11:50:18 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1734051016;
	cv=none; b=K80rPykvBGBQA1N6lIhS+61fbBqV40f4zxKSkhxIwUjihibf4BgMmRsg5h2+DHPRmiu60rvOLu/0ceTW9VtN1NJCzHgciCHFNmBYrJX17fVI41cFFfe6b6X+PGIMLsRWbnm9TZ3s0pZRYAEcdh2JHrJ35hCgVfE6yU7EXyLw8sm7nrTIbcLgKuv5E/OyP0paHigTa/zE0xjPuqJxdSedSpc6S13J08jVbqkxoO14peHsvrzdegtTRY9svONL4h4EnNJR17W/eZRlc0unILflnfZjYo4sHnu2JDQlJsw4RY/fZdO6saiUHBmcQv8b3iKceI54Ac5O6KswnCVMrzTM/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1734051016; c=relaxed/relaxed;
	bh=Ty8EZNmVKAJdhiCOUndN34Bs9JOCI73WRxvTNPMY5hs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lPz8XLIPwldD4MaI8OSDNH6TP5u7QQJ+8LInrXS72ohqD81QDnxFXhWsEbJYmwS2IjRzQI0MVgkAsvt5rtNGz857X1Rav7zT0OGWmrZX6WJF4y1tqLnrCDFn0h65f4XgmWX+RrvR+2hbbfFTh2CW7zHWchCAgs3eBhyvgE/YeLSzdjEzEzMy/L6bATBCK++mVxLysBF4B08dMdi//KZatPHtSyPyWNea42kjfu7SYjk1NuZdyhrRA5wDLYesW0OEuz7NdACJZl8yScqCpqsGtkVAqivEGZMIIXcdyopuAHsfsKfGoEOBqz+tH+f3hfge6v46TquuHg9A00TDnQpamA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=OZsLpUaE; dkim-atps=neutral; spf=pass (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=OZsLpUaE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Y8W2s5CYJz30Wp
	for <linux-erofs@lists.ozlabs.org>; Fri, 13 Dec 2024 11:50:10 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1734051006; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Ty8EZNmVKAJdhiCOUndN34Bs9JOCI73WRxvTNPMY5hs=;
	b=OZsLpUaEbHXf+bb/+A89Nykpu3EK4BiFCmV+YNJFKG0aY+PYxawaloxEqP341iVBi98uGuZsGEgK9b42q2SyRfmB5ZXsLprX6RV35+sEmPsfOMtvD1K1PgToA1lpFoReuT6ihFUaoOhetSVcWt3EVDkvMox9oVpyowpNMGeytTQ=
Received: from 30.170.86.122(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WLN-3t0_1734050999 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 13 Dec 2024 08:50:04 +0800
Message-ID: <d7155d5b-3259-4cab-97b0-95ed267d7468@linux.alibaba.com>
Date: Fri, 13 Dec 2024 08:49:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] erofs-utils: add --hard-dereference option
To: Paul Meyer <katexochen0@gmail.com>, linux-erofs@lists.ozlabs.org
References: <20241212165550.58756-1-katexochen0@gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20241212165550.58756-1-katexochen0@gmail.com>
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
Cc: Leonard Cohnen <leonard.cohnen@gmail.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2024/12/13 00:48, Paul Meyer wrote:
> Add option --hard-dereference to dereference hardlinks when
> creating an image. Instead of reusing the inode, hardlinks are added
> as separate inodes. This is useful for reproducible builds, when the
> rootfs is space-optimized using hardlinks on some machines, but not on
> others.
> 
> Co-authored-by: Leonard Cohnen <leonard.cohnen@gmail.com>
> Signed-off-by: Paul Meyer <katexochen0@gmail.com>

Thanks, applied.

Thanks,
Gao Xiang
