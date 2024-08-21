Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BCAD959298
	for <lists+linux-erofs@lfdr.de>; Wed, 21 Aug 2024 04:06:22 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WpV7H61W8z2yGh
	for <lists+linux-erofs@lfdr.de>; Wed, 21 Aug 2024 12:06:19 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.131
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=fbF5OF3U;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WpV7C51c7z2xVW
	for <linux-erofs@lists.ozlabs.org>; Wed, 21 Aug 2024 12:06:13 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1724205968; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=azulSMiJc9inz0sSvR0ATrEeidesA691iHRm8YDUHEc=;
	b=fbF5OF3UlbSnJck+zJwcg+E0oF1xaYYR3yr9jYa1A73FzfzLtC/CedqA1mg6IdL4IRX3wziZZxXcICtAmA2L+lO6WL0x0dPvkFLKQ9A6S1rkaTK9mW3YmA54qRfj0b9H3Zp/4+ySMOcgLgKpnpoGMFgpsGAlcJ4xEPOem8EPxkY=
Received: from 30.244.149.246(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WDK4ruD_1724205966)
          by smtp.aliyun-inc.com;
          Wed, 21 Aug 2024 10:06:07 +0800
Message-ID: <51209c74-0eea-452b-b9b6-aa8a040b6aa9@linux.alibaba.com>
Date: Wed, 21 Aug 2024 10:06:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] erofs-utils: lib: actually skip the unidentified
 xattrs
To: Sandeep Dhavale <dhavale@google.com>, linux-erofs@lists.ozlabs.org
References: <20240820210123.2684886-1-dhavale@google.com>
 <20240820210123.2684886-2-dhavale@google.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240820210123.2684886-2-dhavale@google.com>
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
Cc: kernel-team@android.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2024/8/21 05:01, Sandeep Dhavale wrote:
> parse_one_xattr() will return null if it detects unidentified xattr.
> In such cases we need to skip this xattr which was our intention than
> try to add it in erofs_xattr_add() which results in null pointer
> dereference.
> 
> Fixes: 3037f8958f3b ("erofs-utils: skip all unidentified xattrs from local paths")
> Signed-off-by: Sandeep Dhavale <dhavale@google.com>

Thanks, applied.

Thanks,
Gao Xiang
