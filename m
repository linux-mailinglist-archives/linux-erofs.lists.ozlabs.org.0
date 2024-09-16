Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1F8C97A39A
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Sep 2024 16:05:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1726495502;
	bh=aWZWw4Ic6FJjibHaMmYz5SGWuWp1jS+MbeK/LtZV7N8=;
	h=Date:To:Subject:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=cbT5IlmR6KPr1PUAXZG0bXCtOYVi9uDk4Jo/8s6hiT6AjBG1THSFETT2++6AGqPrD
	 ZVNxM7ujyfRu6nkX2qxj7IydRW4dZwhJ5a8rtA8FPobATtqVfb+w5akgTGtMm23bXP
	 TQ7EB5IfW/wpU3QzCd4Qf6f8fo/WdJaDcW5nsBBUd/nvCMUFrJuxv16ef/1WVhiMwh
	 mZa8DbAnjFs7WBEPSsvE0bkosEEPgBmjHjxoTOsbwZCWu2O8tWISlDxMlD0hJEVtnP
	 JYR9X77aB6uL8ussxb7b61d+N6CMgXooxqc6jFFHf96Rl7iZprqOx6BrHeMZ7jwKop
	 ALIfAnaHnUo1g==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4X6mrZ4cZkz2yYK
	for <lists+linux-erofs@lfdr.de>; Tue, 17 Sep 2024 00:05:02 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.135.17.20
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1726495499;
	cv=none; b=if54TZ8G5A37A5LTtdWE4doJt4QAnKggOkE5hIkYqzy9WI9u62HZtr4DVq8WjzjPVY8F6pTzK9xEODb7Sqjo6Ouax10doY3wMEFKt4dl9PHzpCjkqRokaba0i9E3TKTCEdudq2p8N3SI4Ag1+uRHSp305JO5D8vvZvoXYjAcJJjJpQTC10cTq0oHLk8dSAfr1PCOy3MA9G+5/MZPvRV44L98/HyMyiFi8CM3qS7IGLlV5Np5M7qFOsuD5tOQnRpYVL+m5hI9MWb23OxrmPIrZWoJzgego/8qqqSG39Kz+I4pfYiFAGDj+IVeUF7UBV7KDMXLFA58eTE/sfuW7in93g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1726495499; c=relaxed/relaxed;
	bh=aWZWw4Ic6FJjibHaMmYz5SGWuWp1jS+MbeK/LtZV7N8=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nSfZEbbVuoVwTtgGmYezUS+9tAJhxBqSqovdHP5BULrnrrGCertyKiEkaNATMIhsuveB/C1SGNIjPUnmB7AFnzN68Wj8LuU1KZbBUc0zcoV/at1MsZXgQrdR6naUZnzubETG1Ydvr6bN398qkaBPJ3RxDSBVG3zX+/RtxCcfqPd1SelHI2YbdfD/9CPWLoC1gS3m3XC1RDge0w0CJ+GqT+DY9gmgpIM2rb2VIBApljlbtLInyZFC2Lc7JRs8+QTan5Eo+zFQYLPy7E6VFe0KSOu0ywrJOlsAcg/FVmDeCre60LbFxupRF/7wv9KXif4JOVG9MCLzPT2BZhVSVxVRIg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc; dkim=pass (2048-bit key; secure) header.d=tlmp.cc header.i=@tlmp.cc header.a=rsa-sha256 header.s=dkim header.b=HzdSuzs+; dkim-atps=neutral; spf=pass (client-ip=148.135.17.20; helo=mail.tlmp.cc; envelope-from=toolmanp@tlmp.cc; receiver=lists.ozlabs.org) smtp.mailfrom=tlmp.cc
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=tlmp.cc header.i=@tlmp.cc header.a=rsa-sha256 header.s=dkim header.b=HzdSuzs+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=tlmp.cc (client-ip=148.135.17.20; helo=mail.tlmp.cc; envelope-from=toolmanp@tlmp.cc; receiver=lists.ozlabs.org)
Received: from mail.tlmp.cc (unknown [148.135.17.20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4X6mrW0z99z2y1W
	for <linux-erofs@lists.ozlabs.org>; Tue, 17 Sep 2024 00:04:59 +1000 (AEST)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7BA5E697AF;
	Mon, 16 Sep 2024 10:04:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tlmp.cc; s=dkim;
	t=1726495497;
	h=from:subject:date:message-id:to:mime-version:content-type:in-reply-to:
	 references; bh=aWZWw4Ic6FJjibHaMmYz5SGWuWp1jS+MbeK/LtZV7N8=;
	b=HzdSuzs+hpn4+o3r1RIX0dcuMo64KGLmgRzK8OuULU0ijgzmuGcAXt5ttoqqAXO2YT9KmF
	OYpPQ343jM16OUFCSRmdCv8gJsCM4rqjIzn8qz0kfcvmdhs4Xs8iopmiVG1XiDmpJsKCAy
	fYv2rFIhRxI5EwO9xjZcJLGCVR5VSJzh6wG8p+ure7pdLVz8h80oQdF6uN9YPK7mHurTWp
	5beBORpQUWJi1OxA1Sk4U7q1kIb+o58GHV6wKf/+9ow98NlXdv5U0mbZaV53jRLUIGtal+
	7D1FnxUXznqhIzwK4peziz+W3sA5hoCRb27d3jLVvNXNrDnvo/Wa7rHzDbAOCw==
Date: Mon, 16 Sep 2024 22:04:51 +0800
To: linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Subject: Re: [RFC PATCH 00/24] erofs: introduce Rust implementation
Message-ID: <iy7twdqdmlxtkh5qfwwqqj2zqgn54q7ovlgoqjhvvyfom6gvej@jt33zq6h7ryy>
References: <20240916135541.98096-1-toolmanp@tlmp.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240916135541.98096-1-toolmanp@tlmp.cc>
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Mon, Sep 16, 2024 at 09:55:17PM GMT, Yiyang Wu via Linux-erofs wrote:
> Greetings,
> 
> So here is a patchset to add Rust skeleton codes to the current EROFS
> implementation. The implementation is deeply inspired by the current C 
> implementation, and it's based on a generic erofs_sys crate[1] written
> by me. The purpose is to potentially replace some of C codes to make
> to make full use of Rust's safety features and better
> optimization guarantees.

Utterly sorry for my mistake.

I forgot CC the LKML when copying the mailing list
so i interrupt the patch sending.

Just delete the first one and use the second patchset,
and it should be OK.

Best Regards
Yiyang Wu,
