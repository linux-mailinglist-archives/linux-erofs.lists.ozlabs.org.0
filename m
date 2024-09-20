Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45BB997D007
	for <lists+linux-erofs@lfdr.de>; Fri, 20 Sep 2024 04:58:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1726801089;
	bh=YMih+D2wi9YPfDllyA5iKM7XhtyK372/GGedwlq9L10=;
	h=Date:To:Subject:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=RMQDHKYa6TAfIdO+s5zmVZEtuF5zoWT/vRuXl8MC4SRY4s7+DUcOYGgBdqPY36PD9
	 7QqGBPbDxbcsNIpHPvcIueV6rPkcLTHn1Oisw2Ng0nsvycPBWbKNQv+7XcPrQQSiue
	 3Zo862BzmuFPMwP2JBgu3+SSuq0DpLWXpuZ60TAC4B1Anv8TjALIp/bg4aZ+eQGH7C
	 VMeaMlA9GzLPD4Z+WOcxSXfO8IF7qqyo8zIvspMobN/oE78moYD3X/4d+ujG/xp3ux
	 nhv5eoLoKX4AzSiVtt2EXJn3OTp8KTr64gP95udNVPm93djtOHYT2SHd8rDqUmDq4p
	 PBgA0dOOezJVg==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4X8xsF2csVz2yRF
	for <lists+linux-erofs@lfdr.de>; Fri, 20 Sep 2024 12:58:09 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.135.17.20
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1726801086;
	cv=none; b=djJbOiF59Eakz19RzHfG6nDX5aC8T63lYDS4UWLKchz/01/wafVj6NsyCB1HX2hHLOz4AKuBxGaTPD7gBo7vdxFkfeQtNQRL5BerY+uqnDKeU0uK9ovsDa3PaukZtBJabwLUbplD0oMz5bYy/VEzVksWKTXb3Ah1sK8IzY/v/23gXLMUY5X+5ku/e6L9NXAYVpd9tcUbex2Nw2YcQWMs1k0x0+ddTCcGeMogjrK4JpEgQKwAtcrQ5fr2uBWeHNCBWaDW13BkZoKrPTwlIKvrlpi5+5WtAzmtoqmq+R7ZD9JPXdmNXebSgYz9Ea7THo1IRt1yvIYszvjQ8Gah6GN1kA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1726801086; c=relaxed/relaxed;
	bh=YMih+D2wi9YPfDllyA5iKM7XhtyK372/GGedwlq9L10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jfSPCpWgBu0cnbLCPnieNixK3/0hgLSC7/J7E0Lx6vDm6w/c8H4III097Grhz9lxoe4P8QuR/nLsCZWxVoBennH6nTIQgaJwJHYU//2fIH6HIKHblLjSWmXy/FdDag2njDQQopnSZaoKDT9fuX8p96SilqncNyjI6YqbB1xm/Y82i/X4LTPB5PAAl6jsQHNgiz8JIIWw26wSjS8jZ6CkmHGI82uf1pkWiEDLDhsuIFIIdOXrfMf0t1IMLcwfr7Ns8vG6M/8OGsIjd7y9lvPqVWT+3z5LM5wzDZj3JF/4mTDDLkQ/jN4UDrwnag5QhkFBg+I8w0PI/LfK949YiOLEug==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc; dkim=pass (2048-bit key; secure) header.d=tlmp.cc header.i=@tlmp.cc header.a=rsa-sha256 header.s=dkim header.b=gnmap5+E; dkim-atps=neutral; spf=pass (client-ip=148.135.17.20; helo=mail.tlmp.cc; envelope-from=toolmanp@tlmp.cc; receiver=lists.ozlabs.org) smtp.mailfrom=tlmp.cc
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=tlmp.cc header.i=@tlmp.cc header.a=rsa-sha256 header.s=dkim header.b=gnmap5+E;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=tlmp.cc (client-ip=148.135.17.20; helo=mail.tlmp.cc; envelope-from=toolmanp@tlmp.cc; receiver=lists.ozlabs.org)
Received: from mail.tlmp.cc (unknown [148.135.17.20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4X8xsB4WKFz2xmS
	for <linux-erofs@lists.ozlabs.org>; Fri, 20 Sep 2024 12:58:06 +1000 (AEST)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 763BC697AF;
	Thu, 19 Sep 2024 22:58:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tlmp.cc; s=dkim;
	t=1726801083; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=YMih+D2wi9YPfDllyA5iKM7XhtyK372/GGedwlq9L10=;
	b=gnmap5+EjwAIwiUWK0HpcE8HCAks0Et9LQ8kadQi6QeoAdN2CxJcPnDpb3HoXeeYNKz7Rd
	PTKv9f6reL0WqH0v4rdRvFf8B2fv2iaMRTq1RmQT1IRp5S68a/2HWa1UuZvDZ5KLKAvCXZ
	kMhQJFvVSprSsMYga52499cV3uiAqhfjE+ZoCufd/x8Mr7lGwqrhQKqVXQ92PwRlqSBWXw
	fsarJDIg4y39MkPXvvy1r7OFhvD8/tNw0f5j6LiZrY68fSORsyuurNm4bSa857RDJTxBes
	0gkQ6hqa63bEPBqhbg1EAgyMcoKqSegmMjZXv2NfGg7pvut4lCkmk1y1y0voaA==
Date: Fri, 20 Sep 2024 10:57:55 +0800
To: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [RFC PATCH 03/24] erofs: add Errno in Rust
Message-ID: <xqta6t7rrabvj4rdwt7bhp2ijxgnfzd65fauhca2rfyfhwxyzj@5wa5h63gelc5>
References: <20240916135634.98554-1-toolmanp@tlmp.cc>
 <20240916135634.98554-4-toolmanp@tlmp.cc>
 <2024091602-bannister-giddy-0d6e@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024091602-bannister-giddy-0d6e@gregkh>
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
Cc: linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>, rust-for-linux@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Mon, Sep 16, 2024 at 07:51:40PM GMT, Greg KH wrote:
> On Mon, Sep 16, 2024 at 09:56:13PM +0800, Yiyang Wu wrote:
> > Introduce Errno to Rust side code. Note that in current Rust For Linux,
> > Errnos are implemented as core::ffi::c_uint unit structs.
> > However, EUCLEAN, a.k.a EFSCORRUPTED is missing from error crate.
> > 
> > Since the errno_base hasn't changed for over 13 years,
> > This patch merely serves as a temporary workaround for the missing
> > errno in the Rust For Linux.
> 
> Why not just add the missing errno to the core rust code instead?  No
> need to define a whole new one for this.
> 
> thanks,
> 
> greg k-h

I have added all the missing errnos by autogenerating declare_err!
in the preceding patches. Please check :)

Best Regards,

Yiyang Wu
