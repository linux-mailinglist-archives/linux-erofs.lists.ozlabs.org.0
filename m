Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id B4E4696CD79
	for <lists+linux-erofs@lfdr.de>; Thu,  5 Sep 2024 05:48:08 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Wzlgp4y20z2yst
	for <lists+linux-erofs@lfdr.de>; Thu,  5 Sep 2024 13:48:06 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.133
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1725508084;
	cv=none; b=FAkPjeZPjd5OTIqBPT04gFbTqmpA/t0NIWuJblhYxMZrEwJzZbE6hsnieOlB43qC565fZgTNOB3hJctPLg9qP59KxTZeU5ZJJqzCYmUlDuv2KNmtjP08LbT1vnUiVbkA0MPlfGqOe3tzfFxVQr5DwLLThRE3ilmq/XBqDh+eOGuCGApPeKli6i3ePeAf+hmrFETKHLjd/Ud3WKmNDMItF1mTqC2vIs3+TXq3SVK+1Vgd+xFuPddqG8mCN5P/EJnLcl1bB5vFPhSK0VLqXTH8B3OqwAwcKYsY9BqN+L4IepVIbhRQyF9yqO5eL2XiSUtyY3ikZpvV0PdUloBsgOsj6g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1725508084; c=relaxed/relaxed;
	bh=pFI+pahaRnG+81eE2WtVl2HkbJm0IUUxQro0GhJkgTU=;
	h=DKIM-Signature:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type; b=MK3ilrCwW+vIe7MjT3QUiwBgvpp8m1NHScipnlCPkXQg1iUI4aXoDIslQ6SI5Xw1973yU2H6J75zqQkgGR8DFkyoMmptmgilOkhKdVX/HWIzU8IhHj7q3DR/Vt5Cai+uG87wvcCcnSX1QX3Sngq1HnyuK/TP7tv/t1uUoUEJ1p8dswm0BEhA6c+3t+lq7Qhl5vfQuZ0P+GL4MoJzJtiXPb+OVzJHnNhJ2W6LOc96SNZLNBSb9NcwlkruQo5tU5KpIGoHwpxtUvaD6a659c6MNV4J2ATF//3NC2Pf6nJTz1IUvWf+NxUTPOf/cqm//Cy8D38SwkQ05acAkLYjxl4tHw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=c4hAiALA; dkim-atps=neutral; spf=pass (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=c4hAiALA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Wzlgl1nQtz2xq0
	for <linux-erofs@lists.ozlabs.org>; Thu,  5 Sep 2024 13:48:01 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1725508077; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=pFI+pahaRnG+81eE2WtVl2HkbJm0IUUxQro0GhJkgTU=;
	b=c4hAiALA6xegQkRNJh+gQQdsqc/zTA8H4WGZ6l7WD7BzmtgKWhEaXEz/5E4qEKcIoXvAgyoDSTCYaIqsv/2I22lVkOTaYE3iJahJqdmHPDdrKaMO5/OVPfM84DG/YlVzmlCFSDfimlF0dfOHDBMkGYubnwwT1OHnE8p59rXsptU=
Received: from 30.221.129.218(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WEJsxlR_1725508075)
          by smtp.aliyun-inc.com;
          Thu, 05 Sep 2024 11:47:56 +0800
Message-ID: <6023d984-335b-4940-83d5-339db0b89c5b@linux.alibaba.com>
Date: Thu, 5 Sep 2024 11:47:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs: simplify erofs_map_blocks_flatmode()
To: Hongzhen Luo <hongzhen@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20240905030339.1474396-1-hongzhen@linux.alibaba.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240905030339.1474396-1-hongzhen@linux.alibaba.com>
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
Cc: linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2024/9/5 11:03, Hongzhen Luo wrote:
> Get rid of redundant variables (nblocks, offset) and a dead branch
> (!tailendpacking).
> 
> Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang
