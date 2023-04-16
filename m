Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 0586E6E392B
	for <lists+linux-erofs@lfdr.de>; Sun, 16 Apr 2023 16:21:35 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Pzsn86Qq0z3cMb
	for <lists+linux-erofs@lfdr.de>; Mon, 17 Apr 2023 00:21:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=GSC3RuE9;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=chao@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=GSC3RuE9;
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Pzsn63DJfz3c6t
	for <linux-erofs@lists.ozlabs.org>; Mon, 17 Apr 2023 00:21:30 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id A89BA60EA8;
	Sun, 16 Apr 2023 14:21:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0617BC433EF;
	Sun, 16 Apr 2023 14:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1681654888;
	bh=jArUrVjOBK3lecBeZm/2KhzUx8jOfQnvVXBNfardV48=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GSC3RuE9wJQvxtZle+yhURnJRPTgo6vh1k1vhrLrTha/GeFkeixqXJkKDJ5b9sk+0
	 Hz5fY+dpTcCXz4YosO9qAICOgtm7RXskrcMEDJq/fUAvlRqjhJ1xb38+G4Qt3EChX7
	 Lue69w0bc5lo15wrI48kRI7tRnEsO1BHjpWHyLkhkqEEsjik4qREnwx66UrhPqUc9/
	 Cl0tUPvcO4QUNQB5v6nz4yn7BahjzO0SwI61qQGxDqN46726X/elLVF/CZSvNjo31T
	 5Y98HWmv4YxuPUraoP4SQazqI2g+HawaKlKZATJBB8ZYAdGQJz5S+mjFtSjpDZaedP
	 hPRGVZG8IYaIQ==
Message-ID: <74b059d9-413a-7807-9c3b-b8cc119186b9@kernel.org>
Date: Sun, 16 Apr 2023 22:21:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 1/8] erofs: move several xattr helpers into xattr.c
Content-Language: en-US
To: Jingbo Xu <jefflexu@linux.alibaba.com>, xiang@kernel.org,
 huyue2@coolpad.com, linux-erofs@lists.ozlabs.org
References: <20230330082910.125374-1-jefflexu@linux.alibaba.com>
 <20230330082910.125374-2-jefflexu@linux.alibaba.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20230330082910.125374-2-jefflexu@linux.alibaba.com>
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

On 2023/3/30 16:29, Jingbo Xu wrote:
> Move xattrblock_addr() and xattrblock_offset() helpers into xattr.c,
> as they are not used outside of xattr.c.
> 
> inlinexattr_header_size() has only one caller, and thus make it inlined
> into the caller directly.
> 
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>

Acked-by: Chao Yu <chao@kernel.org>

Thanks,
