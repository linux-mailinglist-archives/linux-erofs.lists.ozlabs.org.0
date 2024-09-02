Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47304967FBD
	for <lists+linux-erofs@lfdr.de>; Mon,  2 Sep 2024 08:52:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1725259935;
	bh=xPo/aeycxsYyFW1a06c2EYN+hFfylPJIDEUKB3y+AEA=;
	h=Date:To:Subject:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=MlvXMZASXtMT3FLR5sgn96UlU5w5ZaddLPjpfu8a8Axzkg/3xAIkiF0uSHOClKoe+
	 RVOMe+eG4aXkFPGz8X5t3JnQQ6BjrbOmxGCfiNcTikGUh3+S3CPWh+e8vUfhgaK6LE
	 htIhGWAmG46ZI2nTBN4Wh+ZZq00g2EM09Mg50m7USIeKuwa6jCE5hQuegNzi06MlFZ
	 HTiWnbeusUKwDhhI2FJ1rjqthykm+CGbAarhwa7Q1dVtmA3vgZOJGctiqxuqZ3GDzS
	 IO99F5k9izFNzJZD6Eub4fAtdJhkrn4XBKOYy0nIQu8P64Kkmrd/ZsbCY0i/wLr5MI
	 7xBxE4Gqpg/nA==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Wxzvg1d87z2yPR
	for <lists+linux-erofs@lfdr.de>; Mon,  2 Sep 2024 16:52:15 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.135.17.20
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1725259933;
	cv=none; b=jRiYw/CTsFhdAM6sYrR35Xsi+BhU5RLKiUWa2MoGPfMxjS/u+gy+8+JpVtVeT7DMmixwSzU9Z9B9VVGLJIfwDprj7lmvU+uv3rzEeXNPX+ZPF4eeHVQXH0p/InI1zFFa8GGJW96Wu+GBPf+YW75JcfDIloF5a15A9dAzsMFnigchY67+deFCBKEIt9HbnN9aEVAMtCz0cOiRrO2+4KdDWwB1w5XPoqovUObTqPe9DFzAnX4CV3vDhPNjbvtjDZx70I4N7EDCCvlZqSDtknljWoOvO+q5WzmsrXBd897FfhJSW3YwfAixVV/T0FqycBrww630cvduiUbnGOTmZkl8FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1725259933; c=relaxed/relaxed;
	bh=xPo/aeycxsYyFW1a06c2EYN+hFfylPJIDEUKB3y+AEA=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Last-TLS-Session-Version; b=BsE4/797xTGqCkfbLYNVjyfbXl+ZyxaYq+n+JVPRCR0mIZ+C34pXqCulHQfMY8Uo5rUE/svAqsaTpXJ/B34Nvy1OOZQuUb1nDqfnptnCWgdXxftxap0CwBrXHHOzMnW9U+Udk/1h6JK0u3ZZMJR0WD/mHpj8asQBypVztRW2oP0C8vIPxfUBqDUJ+/2oFOm6018OhBl8FcIROmSnsmy1rfc9oZQFiYhZZgFbKjrGGgHaWDkCqLxyDKv4h/bcGIfT2/FFB7WbGCOTEAKbdZOZbDN7xJFE6FDPrkm1aTAXt+WwGAwzpgVEqiwJH/z6WNdDgLmbKZ2SdKQYZEHDqTOJ4w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc; dkim=pass (2048-bit key; secure) header.d=tlmp.cc header.i=@tlmp.cc header.a=rsa-sha256 header.s=dkim header.b=ImrgUVfy; dkim-atps=neutral; spf=pass (client-ip=148.135.17.20; helo=mail.tlmp.cc; envelope-from=toolmanp@tlmp.cc; receiver=lists.ozlabs.org) smtp.mailfrom=tlmp.cc
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=tlmp.cc header.i=@tlmp.cc header.a=rsa-sha256 header.s=dkim header.b=ImrgUVfy;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=tlmp.cc (client-ip=148.135.17.20; helo=mail.tlmp.cc; envelope-from=toolmanp@tlmp.cc; receiver=lists.ozlabs.org)
Received: from mail.tlmp.cc (unknown [148.135.17.20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Wxzvd17Mbz2xXp
	for <linux-erofs@lists.ozlabs.org>; Mon,  2 Sep 2024 16:52:13 +1000 (AEST)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 58871697A1;
	Mon,  2 Sep 2024 02:52:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tlmp.cc; s=dkim;
	t=1725259928; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=xPo/aeycxsYyFW1a06c2EYN+hFfylPJIDEUKB3y+AEA=;
	b=ImrgUVfyCScGbcqVk6ZmSGT45lHbEsEjtXh8X4ZkTkfnV33UoRWZo/g4K2oAC/qBzVOYHf
	1/HhtDT/tsDYiIxcXOabYOPJuEs3C+b4ETNepwI18yKjPUHiEsAzDjf0KFxsn5wOUjOgob
	1WQ8Bq5vhoFhUnKjwNF4yKnczBcHmNugSV5RJAJsoMUCkxBc8yjQJ6P4HkwI7Pgb5fV1KH
	kjPeHhlfznTg1PMYpe29e+dXVGPm11bEouU39xDqysbBiB7f7/3ofntuFxG7+SQMkW4GVA
	4anmOpyHxK8MfcZ//D0ihnj/Eazu2Sq0ZhzCCFmzpG0hP3SDwt+MQ8zlmdFtdA==
Date: Mon, 2 Sep 2024 14:52:00 +0800
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [PATCH 2/2] erofs: use kmemdup_nul in erofs_fill_symlink
Message-ID: <xevmwnwrovlcueuxawmpse545faxoky5nbqlkpzebq7eajr3kr@khnm5umjvctk>
References: <20240902045100.285477-1-toolmanp@tlmp.cc>
 <20240902045100.285477-3-toolmanp@tlmp.cc>
 <843a19f2-254c-4025-8df3-fb25f0862b18@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <843a19f2-254c-4025-8df3-fb25f0862b18@linux.alibaba.com>
X-Last-TLS-Session-Version: TLSv1.3
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
From: Yiyang Wu via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Yiyang Wu <toolmanp@tlmp.cc>
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Mon, Sep 02, 2024 at 01:46:44PM GMT, Gao Xiang wrote:
> Hi Yiyang,
> 
> On 2024/9/2 12:51, Yiyang Wu wrote:
> > Remove open coding in erofs_fill_symlink.
> > 
> > Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
> > Link: https://lore.kernel.org/all/20240425222847.GN2118490@ZenIV
> > Signed-off-by: Yiyang Wu <toolmanp@tlmp.cc>
> 
> Could we lift this patch as [PATCH 1/2]?
> 
No problem, it's fine to me.
> 
> 	lnk = kmemdup_nul(kaddr + m_pofs, inode->i_size, GFP_KERNEL);
> 
> Missing blank here.
Fixed, thanks for pointing out.
> 
> Thanks,
> Gao Xiang

Best Regards,
Yiyang Wu
