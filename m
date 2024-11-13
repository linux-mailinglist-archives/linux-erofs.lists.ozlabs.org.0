Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id B52349C68D7
	for <lists+linux-erofs@lfdr.de>; Wed, 13 Nov 2024 06:42:23 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XpBxk4c0gz2ydW
	for <lists+linux-erofs@lfdr.de>; Wed, 13 Nov 2024 16:42:18 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1731476537;
	cv=none; b=OXnBeCGDS+2kT/jPaA5Oaj/I5wCLfkJmzAzOd0jTvMrPyaiFCPD0l960OJBOJgUB82BdRT8st0SdM9jcYG7hG9uCGjNFM7YiT2uIHhvu1jGWuVurkOdC1VHwk0V930BAXx0e5xpYrYM5/RqRKsE5z213553u6MTIr2Zsh+5z9TZq/S8hmFEnoPQipje3udmnajmKz+Fj4WATwcA6ukTVsQYa71OCxbHHmDvPfVJI4+4zBswYMwS2b9lMC/r+KtGsPUjKRm86ulH24vcQvzb7JroSr9Zf5fdt3y9ibDv0n+xTNY6mm55PCQXLv8hErU4EMH4hbP3k/Gqa00k1kNjtPg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1731476537; c=relaxed/relaxed;
	bh=yEne0tW+PM6uX2zTa5ft510fXa2tIFH7Fj9dWN3aCt4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gbd169kbS2S7vhY7yKHpAmAMa3gOAvD04mTAkz1Vz8GeNqCKiA7hTkMy6wY7l9S+iFIgSuYfCSkze9EDj9s204VoxBB115WqT7du71W1h/igrwnC/qLjsxdJ44LBqLDGhUxRXAqDs8vBzCyWAAK1ek6SO17lPVfJxx6q454Lir4G95Z/djHgzfNWLXnfOxalGQzUGHmm2yjl/7L1rCO4F94O4jw3GxsrZqiKU42nQTJlyc3uUHbqbbO/dz0kBLuXSRGzRe6r6wMQyhaVP10d/yTNDzKoXMtxpoAd6sNKxl/jf/QpHuquc25K4ADGtQazCOEqbKxiYizs5+SzDR5jtg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=ZkY9M/C7; dkim-atps=neutral; spf=pass (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=ZkY9M/C7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XpBxd5BPlz2xjL
	for <linux-erofs@lists.ozlabs.org>; Wed, 13 Nov 2024 16:42:10 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1731476525; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=yEne0tW+PM6uX2zTa5ft510fXa2tIFH7Fj9dWN3aCt4=;
	b=ZkY9M/C7YiE06PNtuVDyC0oQ+UrSoJtzvQ57CEEg9+YTRroVqMbVJSvAcJ+HInaCRQzhGjiLmU6TmbOvnM7IF//pPXQ4OOLkB6gSDr76N9Pq/xIAHM/Lyi5nA4Q1sO35sAMYP3DeoQKtuTPxSswomf73tRSKzwEp71gVkZpAuEw=
Received: from 30.221.129.12(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WJJrPli_1731476522 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 13 Nov 2024 13:42:03 +0800
Message-ID: <4e0bd635-c502-4aab-8fdb-1ef4f2230483@linux.alibaba.com>
Date: Wed, 13 Nov 2024 13:42:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] erofs: add sysfs node to drop internal caches
To: Chunhai Guo <guochunhai@vivo.com>, xiang@kernel.org
References: <20241113041148.749129-1-guochunhai@vivo.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20241113041148.749129-1-guochunhai@vivo.com>
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
Cc: linux-kernel@vger.kernel.org, huyue2@coolpad.com, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2024/11/13 12:11, Chunhai Guo wrote:
> Add a sysfs node to drop compression-related caches, currently used to
> drop in-memory pclusters and cached compressed folios.
> 
> Signed-off-by: Chunhai Guo <guochunhai@vivo.com>

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang
