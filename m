Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76F1491820A
	for <lists+linux-erofs@lfdr.de>; Wed, 26 Jun 2024 15:16:30 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=TfkYJ13z;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4W8MfL74v6z3cR1
	for <lists+linux-erofs@lfdr.de>; Wed, 26 Jun 2024 23:16:26 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=TfkYJ13z;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=145.40.73.55; helo=sin.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4W8MfH09Jdz30VJ
	for <linux-erofs@lists.ozlabs.org>; Wed, 26 Jun 2024 23:16:22 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id A637BCE20DC;
	Wed, 26 Jun 2024 13:16:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39DF8C2BD10;
	Wed, 26 Jun 2024 13:16:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719407780;
	bh=V7D5WN39TEPTg1ZX2xRMHcPRu52TjM3lQojgbcFDHjI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TfkYJ13ztwLMcfMlYnYQ8zXya09i11g0JljVaOOsPtuEuAEMaQvpboKR37dmGH0v3
	 S/aV/ukLgGe5HEx0Db1GTN8C9j5nVjPjFLTbE0Db5HMHDmUHsgAPfT/5tWC6upzSEM
	 heWXdMwgYVhS4WaZ1aieD6OCXs8iet+uJDqZC68U40h+WY3HY+DqIoptsdWLdpD5H3
	 tB7Kr0zM/pCXpsPWcgyKYuuNK3f1H7ixhYxqsxAy3Unaib+0+N2fEZFtdQGc4SUY+7
	 cl45cSlKZloFF9WZv6MoRSbHvbp7KkmnnxnD89Xn6POoIlzIK++q5G6rdkKrqYaA10
	 EKdcWGXRECS9g==
Date: Wed, 26 Jun 2024 15:16:13 +0200
From: Christian Brauner <brauner@kernel.org>
To: Baokun Li <libaokun@huaweicloud.com>
Subject: Re: [PATCH RESEND 0/5] cachefiles: some bugfixes for withdraw and
 xattr
Message-ID: <20240626-ballungszentrum-zugfahrt-b45c1790ed7b@brauner>
References: <20240522115911.2403021-1-libaokun@huaweicloud.com>
 <4f357745-67a6-4f2e-8d69-2f72dc8a42d0@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4f357745-67a6-4f2e-8d69-2f72dc8a42d0@huaweicloud.com>
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
Cc: yangerkun@huawei.com, jlayton@kernel.org, linux-kernel@vger.kernel.org, dhowells@redhat.com, linux-fsdevel@vger.kernel.org, hsiangkao@linux.alibaba.com, netfs@lists.linux.dev, linux-erofs@lists.ozlabs.org, yukuai3@huawei.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Wed, Jun 26, 2024 at 11:03:10AM GMT, Baokun Li wrote:
> A gentle ping.

Hm? That's upstream in

commit a82c13d29985 ('Merge patch series "cachefiles: some bugfixes and cleanups for ondemand requests"')
