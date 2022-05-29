Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D60F53701A
	for <lists+linux-erofs@lfdr.de>; Sun, 29 May 2022 09:04:40 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4L9qKf3DM3z3bkq
	for <lists+linux-erofs@lfdr.de>; Sun, 29 May 2022 17:04:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=mARWlsar;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=chao@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=mARWlsar;
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4L9qKX40pyz2yMj
	for <linux-erofs@lists.ozlabs.org>; Sun, 29 May 2022 17:04:32 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 54A0D60DB5;
	Sun, 29 May 2022 07:04:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E70C0C385A9;
	Sun, 29 May 2022 07:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1653807868;
	bh=g0d7XWj5spS/zSjiU9vUdk8m7L82N5KavPTXtqWaMiU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mARWlsarSRXmB/SNy6OmN3kfPZfy7ryPcBlaboDQ80k8CZHZuU1nFi6YJ+/VQPNx7
	 OOGenJnZQ8wmC6RaClqZ3q4jhTFI76k7EtVfjEbxVmYvOC28Mc2XohYJAv4olJjRGF
	 RZyb5Dpn9GWPkbrHhr5l5ENGMa1Ktnzh7P2Bqd+tDYRYEp8AKUHlEP3P0OjW73JBnp
	 tAO5+NQ50m1PUM9yR1lXAio8IygVeOgPveePAqmnQzOG6Gee9XHeUTJ55yD7Ls/4ww
	 AkKHIEjE3UdlwdkdorflBrHT3FSblGEukPqgjQgLL9L229jtNqNRhxgnQbd4YScqDa
	 Ke/Zdn6RxtQsw==
Message-ID: <5c41e440-93c0-9cf0-9960-446cd5d78837@kernel.org>
Date: Sun, 29 May 2022 15:04:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2] erofs: leave compressed inodes unsupported in fscache
 mode for now
Content-Language: en-US
To: Jeffle Xu <jefflexu@linux.alibaba.com>, xiang@kernel.org,
 linux-erofs@lists.ozlabs.org
References: <20220526010344.118493-1-jefflexu@linux.alibaba.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20220526010344.118493-1-jefflexu@linux.alibaba.com>
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

On 2022/5/26 9:03, Jeffle Xu wrote:
> erofs over fscache doesn't support the compressed layout yet. It will
> cause NULL crash if there are compressed inodes contained when working
> in fscache mode.
> 
> So far in the erofs based container image distribution scenarios
> (RAFS v6), the compressed RAFS v6 images are downloaded and then
> decompressed on demand as an uncompressed erofs image. Then the erofs
> image is mounted in fscache mode for containers to use. IOWs, currently
> compressed data is decompressed on the userspace side instead and
> uncompressed erofs images will be finally cached.
> 
> The fscache support for the compressed layout is still under
> development and it will be used for runtime decompression feature.
> Anyway, to avoid the potential crash, let's leave the compressed inodes
> unsupported in fscache mode until we support it later.
> 
> Fixes: 1442b02b66ad ("erofs: implement fscache-based data read for non-inline layout")
> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
> Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
