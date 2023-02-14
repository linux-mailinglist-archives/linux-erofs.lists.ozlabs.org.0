Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 33998696763
	for <lists+linux-erofs@lfdr.de>; Tue, 14 Feb 2023 15:52:41 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PGPMC0kXxz3cK9
	for <lists+linux-erofs@lfdr.de>; Wed, 15 Feb 2023 01:52:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=oo7LG6n8;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=chao@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=oo7LG6n8;
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PGPM769K6z3c6m
	for <linux-erofs@lists.ozlabs.org>; Wed, 15 Feb 2023 01:52:35 +1100 (AEDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 0B03F61724;
	Tue, 14 Feb 2023 14:52:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 502A0C433D2;
	Tue, 14 Feb 2023 14:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1676386353;
	bh=4d+yolNgm6gYxCCCSu0j7YFzhUwU4Xv/oNwq06e3tIw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=oo7LG6n8qvuXPhFRAM+V081AchrG1re+64lqH4SKsEAnDFcLHnYX/gDpXzJPOaXOI
	 u71TICug8FNzXUKkAmCkm4q24m2QLCSqrmB41azHo73YqKGMcrPLOu18eHcJ/u0S8C
	 0H2XfedlzETDeImK0LYx2Lr78iiWV7Zt0fKQ3VH/TrrQvxWfVswcnSBBSGiHYhGPXC
	 67drY5/jbExRfQ6AL8W/NWaeNxTJT3u037yBYD2uQ1dZoF9DgOWmbxe72igaCHQ2HA
	 UEdHpGKZVyybu3Yo/+hhWbIYjurnQxAlWn/65U+rDzLIRFjfkE/VslzbDYUMZUWovK
	 ACJMy8P/EpJMQ==
Message-ID: <6761e375-8109-13ab-36b1-eda14a041cbe@kernel.org>
Date: Tue, 14 Feb 2023 22:52:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] MAINTAINERS: erofs: Add
 Documentation/ABI/testing/sysfs-fs-erofs
Content-Language: en-US
To: Yangtao Li <frank.li@vivo.com>, xiang@kernel.org, huyue2@coolpad.com,
 jefflexu@linux.alibaba.com
References: <20230209052013.34952-1-frank.li@vivo.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20230209052013.34952-1-frank.li@vivo.com>
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
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2023/2/9 13:20, Yangtao Li wrote:
> Add this doc to the erofs maintainers entry.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

