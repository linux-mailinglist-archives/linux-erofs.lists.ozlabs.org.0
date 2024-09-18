Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id F08DB97BF7C
	for <lists+linux-erofs@lfdr.de>; Wed, 18 Sep 2024 19:10:54 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4X84t50WsWz2yLg
	for <lists+linux-erofs@lfdr.de>; Thu, 19 Sep 2024 03:10:53 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.112
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1726679450;
	cv=none; b=Iggtq0IUjPWTGwWSXmON8f+ODCI0narPjO523vdZnQg+iA3aGo4k8/3YThyCP9x2kC3aeXIcv95HPQoRAhOdV5XIku6d92yiQD0v2HaHWQhV7We4P2FYM88fEu6P8RHdbvuX2Kd5fByrvul11qn2FbmsQyoWwCLiKeTEiRHTHOLddoTKt5Y9OYWMg2Rj2wIKH+V8OwKBt6TArim095CEytHeYZ/OMITBu72+sCiQ4sAkzIWSYhz8u5NboGvG4AZG6+uXdyynapGwsIDL1MpF77/Yc1XKmwHsVhcb1ZLKukPlhKiSiLaXCgkJz0wK6muiW63buDJefQVKftgcZK6Rfg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1726679450; c=relaxed/relaxed;
	bh=GInzei7CbQjuvpAXxB/VLWnKB8DWpmNjc1Ctw9sjAVw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=gyk1Ttuelwnu8d++wyAl09ePbv6Dm2uFK3y1AeCJ3E+C/XqPgCuay2zBhSmbO+EIrCB5OGEVGTHMQ9mvJ/hQMz9X21LTeWWVzfVoeyK2IXZS+sLN1h2WwsEy6yYdq+jjtxKBCFkO8kbkU9lwfcITDKc22eqcxBmBrAnj3Gq9bboJcdTO6h51Jj7gWtRphMDk/S+T+h5OnQfKwbT6J+iMEMrwHUAri4oUkrO7fOFBLLFh2NteEC5eu5IDjgAePvYUk1WjuH4aCmKRM6/M7iEC843Wt/x17JDsixarMLk9M50xs5axt3jzEyvovHvm8YV6Za0q1JEKUU64g6gp5h9aBw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=anAc2ikC; dkim-atps=neutral; spf=pass (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=anAc2ikC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4X84t110K1z2xfK
	for <linux-erofs@lists.ozlabs.org>; Thu, 19 Sep 2024 03:10:47 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1726679443; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=GInzei7CbQjuvpAXxB/VLWnKB8DWpmNjc1Ctw9sjAVw=;
	b=anAc2ikCIN0RsxJNc6B4+Z2goPX0FQf/E/3UEfxR8qkZ9ljWKbhyNa1kYHeCeYci1MdBIXFx5AXZCT22/u7ktdUYqRe6LvIeAvdtUJdDZmT8lQcVpOb3xPRSsHjXZJE0K7y8DqEefaUcuW0eX0H52tB2Yhou2+O+9Vt3k/ZPaQo=
Received: from 30.244.97.54(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WFEy7wy_1726679440)
          by smtp.aliyun-inc.com;
          Thu, 19 Sep 2024 01:10:41 +0800
Message-ID: <c500e9fc-6c96-48ef-bc09-b66aa8298852@linux.alibaba.com>
Date: Thu, 19 Sep 2024 01:10:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] erofs-utils: rename `cfg` to `g_cfg`
To: Hongzhen Luo <hongzhen@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20240918153012.3559343-1-hongzhen@linux.alibaba.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240918153012.3559343-1-hongzhen@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2024/9/18 23:30, Hongzhen Luo wrote:
> Rename the global variable `cfg` to `g_cfg` in preparation for
> the per-superblock configuration.

I think the global configuration is still needed.

But you need to seperate all mkfs configurations from
cfg into a new structure `erofs_mkfs_buildtree_args` instead.

Thanks,
Gao Xiang
