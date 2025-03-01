Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 66A87A4A82E
	for <lists+linux-erofs@lfdr.de>; Sat,  1 Mar 2025 03:52:50 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Z4V4D1bFcz3c6b
	for <lists+linux-erofs@lfdr.de>; Sat,  1 Mar 2025 13:52:44 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1740797561;
	cv=none; b=FLilBq8pneTEXe/y/qQGIIJRGi2Rev+5IOgK9SH1JjZJUPGQoN/COwvJhbJ1UfKO8CeNjsl+V+u4gwkDqYkgpOPqOCqgn6I83tOlZtBvQdQsNMxJu1/0Uo9UGstFppTVpYKsbHLpnqRn3Z20787xel3Mi8Ul5zcv8OdzgWh70uG7zNX4xFoOXkg96jMPeyZKijVq+eJCEMOxI12bK8R2GouyH/1KfBfBLYqriCLt4DR5Mr75YWZJD0JpEl9JZHO42nUQ60lXvBNYOtlf90OkI351Yzf8QMZinl8cM3v+14Hv4okLXtlDAdU8v8Fzao8Ce0gtFDCUP5CbvCt0/cEpNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1740797561; c=relaxed/relaxed;
	bh=yBJ/YWZwYMtRqOfTkO0z7TIkn5oTZoJWOZUWl97CPZw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jXjivWqubqFb/3NZALjeqwe6+sh9rrcxKtEYxoVxyx6oISR/wNZg18rI+m869AgBvO9HXl3maw0DN6BHx/DgUkcxyj8gCNWZQUAEgj7JA2KgKiidmcSusMgKit3eeJzbhoo7mc+7sdiOPnHM0ncR90IOldu+DV313+R/A+278dwlWtXQ3jp6S2yPWtS9G1fnKi3YguoyfqvBU4UdLYGWGlcs5hkDdchWezlotTe3d1UEqkEM7LoiViMKc+7CZ3NYzhkShxXU+VByaNF0SJItATiN6ANfrOTKvSMMg9E0FKDlmXHniiALSjJd5E2OozYLOmieIMpVRxHS/B8e1uQt9A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=S4/AzKnQ; dkim-atps=neutral; spf=pass (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=S4/AzKnQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Z4V482SGGz3029
	for <linux-erofs@lists.ozlabs.org>; Sat,  1 Mar 2025 13:52:38 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1740797554; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=yBJ/YWZwYMtRqOfTkO0z7TIkn5oTZoJWOZUWl97CPZw=;
	b=S4/AzKnQg3Ylu9RRF7zkl78J7xSzuhJE0j9Vj9J4Zn3igoG3mJ08TnMppIWbPIqiR84P/hi/K1/uALtgPYZ5WJBuEwFXJeCSLKqczPwwTHUpDb1NPOUP1OQyxFA+LNgMw8Ms0LRuQZDaqEaLPsftROaBGcBNYwG/OBb6Vk4N3ak=
Received: from 30.134.66.95(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WQRC.Xs_1740797551 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 01 Mar 2025 10:52:32 +0800
Message-ID: <c9cf602f-de40-4917-9f8a-d6b88e57482d@linux.alibaba.com>
Date: Sat, 1 Mar 2025 10:52:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 0/2] erofs: handle overlapped pclusters out of crafted
 images properly
To: Alexey Panov <apanov@astralinux.ru>, stable@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20250228165103.26775-1-apanov@astralinux.ru>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20250228165103.26775-1-apanov@astralinux.ru>
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
Cc: Max Kellermann <max.kellermann@ionos.com>, lvc-project@linuxtesting.org, Chao Yu <chao@kernel.org>, linux-kernel@vger.kernel.org, Yue Hu <huyue2@coolpad.com>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2025/3/1 00:51, Alexey Panov wrote:
> Commit 9e2f9d34dd12 ("erofs: handle overlapped pclusters out of crafted
> images properly") fixes CVE-2024-47736 [1] but brings another problem [2].
> So commit 1a2180f6859c ("erofs: fix PSI memstall accounting") should be
> backported too.
> 
> [1] https://nvd.nist.gov/vuln/detail/CVE-2024-47736
> [2] https://lore.kernel.org/all/CAKPOu+8tvSowiJADW2RuKyofL_CSkm_SuyZA7ME5vMLWmL6pqw@mail.gmail.com/
> 

Thanks for your effort! Patches look good to me.

Thanks,
Gao Xiang
