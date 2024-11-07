Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 9804B9BFCE8
	for <lists+linux-erofs@lfdr.de>; Thu,  7 Nov 2024 04:17:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1730949425;
	bh=FDFljPqreHGXZzFps6yVs6u7SRUvn0QnjczGBs6Zl7w=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=DgkIvAxehs7BWtRsHx9akFmUQi2BdUEcEVW0WKnIQcfPDoVptnSF4kQsSYWxy3VTM
	 SsBXlaXyNyf2GJlL5xxlblt7FEW7+H2Yj54hYSVO88Nyu26sjCSZk+bayL0k9XdV0z
	 zIfi6JAGtHLNoSyQl10G3LdLsNzx7AcuiyeY0gK54Bcz3E9X916GxtbD6WfcFnbfVv
	 0gi+Y6cTKQVT0DuG1ED6+ceTqp29ukwtNTSnZnn5RC0ZZn9aUF6xXnFZ5N3LepEOpn
	 zECyQ/AHwADhHGrfv7j4CeTzHiwi9iPcL9Q65hTuyNOLFxrLsCFWjXVrFQu6l9BIFl
	 g06mf9M0ldIUg==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XkS0x1Bpqz3bkY
	for <lists+linux-erofs@lfdr.de>; Thu,  7 Nov 2024 14:17:05 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2604:1380:45d1:ec00::3"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1730949423;
	cv=none; b=VoPqfYQDEpkbh/1878knr3u6bsYlMEeFYA87mYKa4ZhT+VsBRp7cZnrPQnzTWyvzATsLWlD/ri6LcKt2WjDKcPrlTslklPJd1RiOhNDUTDwifRIohL3Gb5IY1Caw4QRd+ELx+GRgk4k4cjTK0xaj1MR85CgAi1MkwisM35vOPJ2hKC5L1J9ZVxOA8fi/DESzDaHHPRkWArQN7nDTUL9qBiTUOoppyGZe0yzqxBRF0y9kXdb8yMk0AEsnfeqhp5kL3eztiijv1amh85fo8uNkR5mBjGjRxPAL2EjEjSiM4i5xNwpKvSwa9hjZCq3cSAmr0D8lcK2p3GGr2H5ndBh6Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1730949423; c=relaxed/relaxed;
	bh=FDFljPqreHGXZzFps6yVs6u7SRUvn0QnjczGBs6Zl7w=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=h3xgsvNKvSbLnAXc5KSHt9Qgo3FSCAq4DLljVCrQH20ACg41pWHAMYbmbaHKDNjco5/kd+mfwxmXXXTUlciIGolVnXenemgztDZ9QeEJVI25MC+nxJ/nFGt9JGwSRygPLlmP1og/5yGNozlQ4fFv5gIJc4tCs2YRqBNGKQUiDxd8kXwA5usEl1zqboFxuKp9sF2IHmvaXmpMY6RfmtIgos0JXM48kBBYEDXiMnm75xx9WEt+9kodMjJBQ3108Bxxw+PaoDTpabtciHqkhF5CJ5eumAe0YJk/a4Zs4ifhXrbw7hoMtE71t7rSDbf5Nv1Ur96l2QlHSeEZtpezqRVxpQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=PJYhx2Uh; dkim-atps=neutral; spf=pass (client-ip=2604:1380:45d1:ec00::3; helo=nyc.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=PJYhx2Uh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:45d1:ec00::3; helo=nyc.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [IPv6:2604:1380:45d1:ec00::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XkS0t1XHxz2yxP
	for <linux-erofs@lists.ozlabs.org>; Thu,  7 Nov 2024 14:17:02 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 114D6A42167;
	Thu,  7 Nov 2024 03:15:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15DFEC4CEC6;
	Thu,  7 Nov 2024 03:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730949419;
	bh=JpASP94lH28Q5yVILO/aHiYqJ+zhcAvGYpyRu49BgR0=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=PJYhx2UhrPb8EmIiMUbxMvmFRHDGmuxpMCscO8U6j94hR7ulRF0ajQUay1aiIQrax
	 a6dWtdWSYh+EHxt06h1ebnmHiEN2ZL0a/1TUqEUw4gFTjyymA3YQ82h3yMlTu/pcDU
	 RqbcGif/vj8J/+4BmN61flEgNBa5fzIrIu6UokwDRgVXPfjYhlrxmwWrkGziTVAqe3
	 PlCuoLWjOZFzL7jnCkgKgT2tusHa4LiD8O8xyNZ6beoJgp5PSj48UZ67t9LFycNhQ+
	 mx6IcjBj7YYcjD09UV7WD/jR+JJ+5hmxicjLmX7cvHgG84KXfB1q+KPnqVC0tAr55f
	 mKkSYEmiwg+LQ==
Message-ID: <3e53d2ea-564b-4612-ab46-69b872758381@kernel.org>
Date: Thu, 7 Nov 2024 11:16:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] erofs: sunset `struct erofs_workgroup`
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20241021035323.3280682-1-hsiangkao@linux.alibaba.com>
 <20241021035323.3280682-3-hsiangkao@linux.alibaba.com>
Content-Language: en-US
In-Reply-To: <20241021035323.3280682-3-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.3 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.0
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
From: Chao Yu via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Chao Yu <chao@kernel.org>
Cc: Chunhai Guo <guochunhai@vivo.com>, LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2024/10/21 11:53, Gao Xiang wrote:
> `struct erofs_workgroup` was introduced to provide a unique header
> for all physically indexed objects.  However, after big pclusters and
> shared pclusters are implemented upstream, it seems that all EROFS
> encoded data (which requires transformation) can be represented with
> `struct z_erofs_pcluster` directly.
> 
> Move all members into `struct z_erofs_pcluster` for simplicity.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
