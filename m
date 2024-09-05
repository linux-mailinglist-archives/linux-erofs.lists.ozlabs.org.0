Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id B0EC796D3D7
	for <lists+linux-erofs@lfdr.de>; Thu,  5 Sep 2024 11:46:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1725529612;
	bh=dKy8UrKnzxLsW8kYvgZjuWORDMsIiV5BrXA/naoLgnI=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=QRri+trpVcb7XWwBZUg9sJPr4Y/hz9gBTX2e+gfw/x9GXmJUToySynhIMduE5aU82
	 TdNqTG0aSFUfyNr+jMLdm68Ml3VGe7fFIq+MG3ur68uC2i7WnuJEMIMuEbAWXecmx/
	 gv0E61nmeiB/cteopmMPKlXeGuF0yhOEFHt7PPIqqhsA3KEOA/0ofPGwdce8kpWlc0
	 1kaNJuG1aE25XZTPYxQbrPmkcQdl757qraqPohWOMoi7j0rhcHyw4DoRzYwY2IaHmy
	 ZCmkSnkZYAzPkBv6svrbQBkA2Vl3ToikwPk3ykaRVZjIaESvq+KHk/UQtTSThUBKyM
	 BU03JqWVQZDYw==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Wzvdm64m0z2ytm
	for <lists+linux-erofs@lfdr.de>; Thu,  5 Sep 2024 19:46:52 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2604:1380:45d1:ec00::3"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1725529610;
	cv=none; b=C84OeCPl8cT+sxr9IDX4tRgKkvRoorAdQhyEqHaav5vcufCdWhETf8XfcTh3rktOl95txF0MeTDceg2B4hPYYloPteM4zLjjxQxO23S4FjfkJkmgihvlng7vBQO2s8HWcYCMX17KIPzBYKE6TKGZOzKCV3tqmPP2uNGhXP8GrAeOKiJvBv5nhlJGHbpc0UVU3+Q+rEJNETElPk+oAA9uKQ48n9+Pv0AGslcMEcvWfOfXS+FueVFzGoiN92yM/zTTovVemerV7sg3xzneHPvCx+xBAmTnOtc3IfoeWspBcYQjLLx9sChD1nFBRjS19eetQ19cBDvJHB+qZc2czc/aRw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1725529610; c=relaxed/relaxed;
	bh=dKy8UrKnzxLsW8kYvgZjuWORDMsIiV5BrXA/naoLgnI=;
	h=DKIM-Signature:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type; b=D3MntxbW54dumxpxZcURj8K3N9qjMBKPFWg+2f8oZZnYNNfSiqY8Avfn165Zw7DdiRNxSqm3EKp1uQByuKq3XTf6to5QqRXwfnjYFKQZqDNvyEl0L2+KnyHOoBM0XgvAOLbanleNGZ+erU1KQx/eYhZNCPicXymDOkHj6F20e0GIoAEh1lNCWKmPK64AH89ApbQIFkTX9TkJE8VAFZ++42awRD71G3LvMvzJeyp3tH9sMpy3BzIRMKPWWWPpPUxP0RnghfZ4GD2tNKUS3bkMhN7XzNdsqG+MM28aK6V9hDJvN7C8nv0ZO1PQs3BH9dZshTkqdGwHX1Kew2m/q47AmA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=VQ8MjYSN; dkim-atps=neutral; spf=pass (client-ip=2604:1380:45d1:ec00::3; helo=nyc.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=VQ8MjYSN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:45d1:ec00::3; helo=nyc.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [IPv6:2604:1380:45d1:ec00::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Wzvdk1rf0z2xGW
	for <linux-erofs@lists.ozlabs.org>; Thu,  5 Sep 2024 19:46:50 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id E48DBA44641;
	Thu,  5 Sep 2024 09:46:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0826C4CECB;
	Thu,  5 Sep 2024 09:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725529607;
	bh=YEneNQaX0gxRmH24YN6kZK5p+5+wcuX0UjfdhlRhrPI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VQ8MjYSN23iF0GjoNHIf2lG7dxiaT/6deL90C9964Gz0ggxZKeymMpPHPfvhHgplp
	 Vr69oPsuYg9KrnOCkgm+qoD13wR3MQKcoddgA2CK4p/fK+HPJc9CC5ulkzwREayOvz
	 AhxudPRD4tNGOf/EEvyVpAqwEngP1PUh2lzrC5ev/8LVFkCa8ogzujwu5j+PbhZweZ
	 WJyRu6d2fQfSb/uKl6Yn3QZvd9fmQ9kz5xWEKXHfBzK5RAYbnPN/rZFNDcJIf7cWxE
	 H3+jY/xKvmyvOEwUAWTX6xiB8w6hvshZvCUiP8L1OrgWR1STggKTrqD5WMvP1bhMyM
	 7ucZD4bEzypBg==
Message-ID: <eed65184-aeb3-44e9-841a-3d5415e82a63@kernel.org>
Date: Thu, 5 Sep 2024 17:46:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] erofs: support compressed inodes for fileio
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20240830032840.3783206-1-hsiangkao@linux.alibaba.com>
 <20240830032840.3783206-3-hsiangkao@linux.alibaba.com>
Content-Language: en-US
In-Reply-To: <20240830032840.3783206-3-hsiangkao@linux.alibaba.com>
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
From: Chao Yu via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Chao Yu <chao@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2024/8/30 11:28, Gao Xiang wrote:
> Use pseudo bios just like the previous fscache approach since
> merged bio_vecs can be filled properly with unique interfaces.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
