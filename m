Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FE99A07634
	for <lists+linux-erofs@lfdr.de>; Thu,  9 Jan 2025 13:56:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1736427380;
	bh=p9c2PdK2CzOA/8sbI0/GcwW68L6cPEml+Xfh4wWkQe0=;
	h=Date:To:Subject:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=eHL86PTX3NIMmXufQamelpuW3jsTCkn5OLv7nGiGWH2jA0mFy/C1uUYPIOvUcxU/0
	 SAr1Uq4T16siAp0HHQ/ZTWMS701dRdssNQBxkZOZfzgOsUV8dw4JAtI5AC4Bvj2Vpl
	 rN7ziib9jviBD8/v5YJRyoRxucK3jMOQJliSVVdpRDW5tkLlAXdMdbTtc4Sb43mxSc
	 IDqlFkJPVcz3xaB/Fcjhhf4WhDz6o/c6UBchdZF8szcG4LtA0XKEeUQs+a9gLjiSC1
	 MdPkYees9oRgISgHLdqIqmPzoDQVJ6sQ5LKcKLlrYxH6mA5zfBTEwdxwPKBmn/9w84
	 YPR6x8NBQ8JeQ==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YTPtD6CX7z3bvW
	for <lists+linux-erofs@lfdr.de>; Thu,  9 Jan 2025 23:56:20 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2604:1380:4641:c500::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1736427378;
	cv=none; b=AyASZJLcSaQjNUixGWzZfQa7dxT3rnNjPqGSUn7Dq7BloWjxrRnXtUBd/ksUZ4QUikfHNHFJe/Dies7Y4ztuFlBUMNDA81l+RbrUCEmTY8bVJTwiYdHIH5wHaluVQKs2uhPMLKP3M3yn450u1DpZiE49Zyd68kPI+PHJnXapcI8wjLJiw4WaNEkuARtvyzDtYrCLXqXYFM15mV+E98E/PEfpZTuEhwlmAGVHsyxb+BzzW+ZUaLd8tNUi9uefNQ2obT3c7dN2kz4tfSslE4qXL0wYKck9P0/qONXbmHa2rVMV9+wjn+W6JTiZ0pQUuZlNw9CnkM/PL9poOpWHsbB9aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1736427378; c=relaxed/relaxed;
	bh=p9c2PdK2CzOA/8sbI0/GcwW68L6cPEml+Xfh4wWkQe0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oMtQ6sb8NFm+IFqvGdbSveQKOU3uDd7OrmJM7OZxDTNuGM2cVOuQVjKMyymb5KCIG1z+UnzNuwKdVVlnyyBQvani3r2krbMfLKM063WG2Q7N2/7eV7HgT6eDxsz+p2OHipP84455MOduBCyjzZA3WBEonaVCkIiX3EGdjQgOlzZARpY1IB12Ll0n+2+NLmD/BjcvSw0nFX5EhKvXatkzgh4nwIL7efIzZxX3g/r9DqTw8tjJjg4wYJnYbZb0ItT0hCL1vN3DKr57SSBIsfDLskDKcgOFLZu5wUY45DEzUqX+aVXxqfRb4IuvB7wBi6VlACel+zjmvrhw/V9LSBBsqA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ACJ5kVH+; dkim-atps=neutral; spf=pass (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=xiang@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ACJ5kVH+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=xiang@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YTPt85bDNz3bNm
	for <linux-erofs@lists.ozlabs.org>; Thu,  9 Jan 2025 23:56:16 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id E78E65C585B;
	Thu,  9 Jan 2025 12:55:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FBD5C4CED2;
	Thu,  9 Jan 2025 12:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736427372;
	bh=68mdL5BCy26tL+s6tDRSfJEh/nwxVuNqgvej561MHr0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ACJ5kVH+VqxxybRnpHVUTMTZzAMtfEPNhqqJwVul16g2+STEOOQmhPiuuVwsLGK+n
	 49TEsCcMDryVHoCTyCOo14hsb7GjH+KpnoNuO1w7ZfEqD3IxoPjmmsQ31PsKF4cQXn
	 sIPxhmD8AwO6KCguglVjNtWRSNU+Cjmkf5Au3wWlVh4CZ8GzMgy1aQ/iInES3zM+dw
	 IiOoomSZZ9vgRGbQwDWxj8Q/uXsdjcYprrEMgVxUZGigTkwipDn4c45PY+6afyjUsS
	 ogJD0lfiJ4zAluggCrFkmZTyI3TY44HNVSlZwSfoYTQFjVjGOhGJw45L+o2h7Ev3t8
	 yJCaIica8+zCA==
Date: Thu, 9 Jan 2025 20:56:08 +0800
To: Juan Hernandez <jhernand@redhat.com>
Subject: Re: [PATCH] erofs-utils: dump: Add --cat flag to show file contents
Message-ID: <Z3/HaEqw6m/Aq0f5@debian>
Mail-Followup-To: Juan Hernandez <jhernand@redhat.com>,
	linux-erofs@lists.ozlabs.org
References: <CABxE0VzSbSsdoefYCg+cDP=TP9-tMARHr9D9mvrYtrkCY-aucw@mail.gmail.com>
 <20250109105611.178398-1-jhernand@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250109105611.178398-1-jhernand@redhat.com>
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
From: Gao Xiang via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Gao Xiang <xiang@kernel.org>
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Thu, Jan 09, 2025 at 11:56:11AM +0100, Juan Hernandez wrote:
> This patch adds a new '--cat' flag to the 'dump.erofs' command. When
> used it will write to the standard output the content of the file
> indicated by the '--path' or '--nid' options. For example, if there is a
> '/mydir/myfile.txt' file containg the text 'mytext':
> 
>     $ dump.erofs --cat --path=/mydir/myfile.txt myimage.erofs
>     mytext
> 
> Signed-off-by: Juan Hernandez <jhernand@redhat.com>

Thanks! Applied now for testing.

Thanks,
Gao Xiang
