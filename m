Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id D0826A136A5
	for <lists+linux-erofs@lfdr.de>; Thu, 16 Jan 2025 10:32:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1737019940;
	bh=E4gR4uEF6MWST0PMj1Eqs0S9oESBB+qZiqhx4PwE5s8=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=SVHseK/EcpbePQC9HoWZ2zysftFb3jiplLCxXmT0TWBm/emPWhJmpzbFfUSbubLkE
	 Ykg7h9UzbccjaISr8Enp1jsFT0my8IWzAj1XlsGXnWW0OOhkV6xzPMwX7lJbKOiNh/
	 +6AVLXVALUt3g3ELslAqYfpwrbTjcEfq00npH0LtpLROWnCtGvGuCtoDHVAIUteQkt
	 ggbcvOcZGvwJoO/SzMP4UZZmovvt60IHxeWep0iKym7s5Ym9aku206MUn9VybAN4EJ
	 DmuC9++VAiC04rGBsV8ibks/yvASouafDVlJmSaBeyCG0W1ekHkjvxCNLTu1kehih2
	 UMnTi8HUQQfJw==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YYd1c4s0Tz3cbl
	for <lists+linux-erofs@lfdr.de>; Thu, 16 Jan 2025 20:32:20 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2604:1380:45d1:ec00::3"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1737019939;
	cv=none; b=ZkKIcp0MoeOzRE1aVtpqYTYDqdCmVy6+TOJT/NHUDkHNS1wNHjui4/1DXzoOJ3BYpiT95nyG5+QrNc/Dfjb88kG2GUBkwg4Z47N4IzYUxGj1KvwGOjJV/gdQkQvlgS38/SYPA39siqvonD///Bwu7yOXqarM7bdu1UD+j4DAtwUgVXmfa8BcOANI80i3KhJK6mI9grLxC1yTz67n0FOVE0AiXS6RPUy78zRZOSHWeND01LDE3tkGJNgCyPuwDNEXRlqqOAhBGth9yFBgP5OftmSA2zigO44AFGfVrp0RSrp0b8i5GDxPGzfxncdreERlWKlAxZ1ZZ5Lqcwf8VOtWlA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1737019939; c=relaxed/relaxed;
	bh=E4gR4uEF6MWST0PMj1Eqs0S9oESBB+qZiqhx4PwE5s8=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=EJBYPaKN+Zp4eZxbRJQnysTBxnQddCyw4h4ur1+uRqCYRuH6pysS95N36EbGP177UoAssssdH7ArcIRsEi8hL6LMNIFF5utnnM+X2eKnF60TVqLbI6GqjMu3TW0izRVttrHIm9U5as/iAFPpCNODV9pywpJAXgyQZSrypdCPxf/IwDfS7D1ZcwQjl1T+S20A+ao8RxvGV3Jyw8bCyhKXDhmiZfJ8k/bLPNmk+GC9m9ORguzHK4JrlAegILsC6+FsGe2LtQa5orWN3psMszsyrrIPLOee7FOnH1eRW2UYuRfOaziv7sDLECkDo65dUrBLhP9eOZNDrIlihbhs8EMqzQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=qRDkKaB3; dkim-atps=neutral; spf=pass (client-ip=2604:1380:45d1:ec00::3; helo=nyc.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=qRDkKaB3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:45d1:ec00::3; helo=nyc.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [IPv6:2604:1380:45d1:ec00::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YYd1Z5SP7z3bfc
	for <linux-erofs@lists.ozlabs.org>; Thu, 16 Jan 2025 20:32:18 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 1BB85A41331;
	Thu, 16 Jan 2025 09:30:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9450C4CED6;
	Thu, 16 Jan 2025 09:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737019935;
	bh=RJnBHbzrGwslxnnKzFq3PMIa04GMj6UcmJVLXDnY11o=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=qRDkKaB3s17yoRBJ++OGBfv6F+pgIAprxNberdl1sWkQ2sBnwZucfj9eP7DkT4ldA
	 7EL8pJxl9wVKvqT9rnSjwIRwTr3pQGzNq2NBZzSByn98ezL1NHOzBGxED+1b+gjAOj
	 GvcS5vGziFvZwoC4zNszUOgkJnfEabbpAzm2gTqQThhaSuwmM5bg/q56eiRVdub9q1
	 5lk9+9yXFu+vyL5CidZNy8a46MoIKzFvHGUbHYb9tn8nAZcdCCsyDf/5YbjeJDt9Rb
	 7MheE3oR/XlBC4wG4F+watuPPzQHWW/HIjGu7vest+uUG741/1fsQOkCGhUftuQM/W
	 pFh7ICrBxF98w==
Message-ID: <ff80d2d8-0d66-4e11-9c7a-3a7c457074d5@kernel.org>
Date: Thu, 16 Jan 2025 17:32:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] erofs: get rid of `z_erofs_next_pcluster_t`
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20250114034429.431408-1-hsiangkao@linux.alibaba.com>
 <20250114034429.431408-2-hsiangkao@linux.alibaba.com>
Content-Language: en-US
In-Reply-To: <20250114034429.431408-2-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_PASS autolearn=disabled version=4.0.0
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
Cc: LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 1/14/25 11:44, Gao Xiang wrote:
> It was originally intended for tagged pointer reservation.
> 
> Now all encoded data can be represented uniformally with
> `struct z_erofs_pcluster` as described in commit bf1aa03980f4
> ("erofs: sunset `struct erofs_workgroup`"), let's drop it too.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
