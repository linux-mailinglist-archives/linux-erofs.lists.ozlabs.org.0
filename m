Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 73486962D6C
	for <lists+linux-erofs@lfdr.de>; Wed, 28 Aug 2024 18:15:02 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Wv8dJ1Y6Pz2ykZ
	for <lists+linux-erofs@lfdr.de>; Thu, 29 Aug 2024 02:15:00 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1724861697;
	cv=none; b=UJoHmpYX/EtqMW5FK3O2+t6GAR/5EuiN0qJnVMajvAvZcCohDyaPKSaBmuZTGmtQPi5UtQ9fmS+hqvRe+HUrOTXwPGZ+XaNDUzJCNXJQ3XvrgKuP9G1qYp2CUV5e2kksWAVmB9iD2t9YR/OH7jYUPrUJFItwrt3yy25WlQ/xqyZgwjLmknDXXgdoMp5LY+q/7YyYNgfJLvjusgcZQkkKY6U6JoYjtZGeDM/5d6VSOCkGArSF1p+VjHZ+1HtrF2k1yJQawTWbzQCMI+hkBjmCr20U7cacbk7TKFBeP9GznjkCvhg2eYCrtht71fVhU3kdLmUKd064kv6Y6PuQdGfTGA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1724861697; c=relaxed/relaxed;
	bh=7FGxU1+SHbAVv8pRNHhBLmltkerfyg2mQ/Ca/+AJ+l0=;
	h=DKIM-Signature:DKIM-Signature:Received:X-MC-Unique:Received:
	 Received:Organization:From:In-Reply-To:References:To:Cc:Subject:
	 MIME-Version:Content-Type:Content-ID:Content-Transfer-Encoding:
	 Date:Message-ID:X-Scanned-By; b=k3aCzUiomoPuXJH6N9F+0eNxJEc+4hX1UqDGUeIW9sK2CRPQ+7d5fUAWqAv1MDtnfue/8ULMBQc1A0WGOrJxPJbDkXjFvIlcyriMoUlccaFkAptq5a+ulRhlHzoZbR2gCQRmlL62kN/8eug7rSUrRJph5/LM74dThzwgXsx78Y7BhXL7FTeLkDh1/r4HRdFQZxQZcx+t1Yoci4mI9XQQNVYlz4x/Bx5ncZmaqVFU+9MVkxEhlaP7PimxRHusr5VubO0GPP2xzH9d0GnkDOQpUF87rCc4Kt+oqlmzFz1hg/DYwFHqlbuYLXeQx284seEbdlfSLYjS1nHxiSvEfubv9A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fqKmwyhs; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Cw+QE+nD; dkim-atps=neutral; spf=pass (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fqKmwyhs;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Cw+QE+nD;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Wv8dF1Cqxz2y8X
	for <linux-erofs@lists.ozlabs.org>; Thu, 29 Aug 2024 02:14:54 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724861691;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7FGxU1+SHbAVv8pRNHhBLmltkerfyg2mQ/Ca/+AJ+l0=;
	b=fqKmwyhs/4o9sqRot/fEcT6Mft8DP1BE/S1hmLSHTWFAzD27v/3M093/bhidP8ZhMsaod4
	5tyLymKhfwe6/6Z1qfgfjsRruQHiOoWD+nF0EwE+afzUPXXb5IVsDaC8gR1EJHxJhJtqhW
	VwW0CW3k7UfcH2+hvUxzQMAl3k1DHyg=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724861692;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7FGxU1+SHbAVv8pRNHhBLmltkerfyg2mQ/Ca/+AJ+l0=;
	b=Cw+QE+nDbgUma4RqIXbHAIEsKRhJXoLg5uud+djH7kJYdP55RQfRteWzxVDDSkR77GqOW0
	sVsO4FQV0oK8gpEifIe1l6mshn66PJkyh76byHpaTQC5rsiV/lfNaUl3pPo77OzfNlQGwj
	pymBa5lFzLerRTEuHVG6WA8/8wLaF2Q=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-132-4Po9ynhuPUCy3Q3CwKL4bw-1; Wed,
 28 Aug 2024 12:14:47 -0400
X-MC-Unique: 4Po9ynhuPUCy3Q3CwKL4bw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7DEB11955BF9;
	Wed, 28 Aug 2024 16:14:43 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.30])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5C37519560A3;
	Wed, 28 Aug 2024 16:14:37 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <11c591fd-221b-4eeb-a0bd-e9e303d391a6@huaweicloud.com>
References: <11c591fd-221b-4eeb-a0bd-e9e303d391a6@huaweicloud.com> <5b7455f8-4637-4ec0-a016-233827131fb2@huaweicloud.com> <20240826040018.2990763-1-libaokun@huaweicloud.com> <467d9b9b-34b4-4a94-95c1-1d41f0a91e05@web.de> <988772.1724850113@warthog.procyon.org.uk>
To: Baokun Li <libaokun@huaweicloud.com>
Subject: Re: [PATCH] cachefiles: fix dentry leak in cachefiles_open_file()
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1043617.1724861676.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Aug 2024 17:14:36 +0100
Message-ID: <1043618.1724861676@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
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
Cc: Christian Brauner <brauner@kernel.org>, Yang Erkun <yangerkun@huawei.com>, Jeff Layton <jlayton@kernel.org>, LKML <linux-kernel@vger.kernel.org>, dhowells@redhat.com, Markus Elfring <Markus.Elfring@web.de>, Gao Xiang <hsiangkao@linux.alibaba.com>, linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev, linux-erofs@lists.ozlabs.org, stable@kernel.org, Yu Kuai <yukuai3@huawei.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Baokun Li <libaokun@huaweicloud.com> wrote:

> > You couldn't do that anyway, since kernel_file_open() steals the calle=
r's ref
> > if successful.
> Ignoring kernel_file_open(), we now put a reference count of the dentry
> whether cachefiles_open_file() returns true or false.

Actually, I'm wrong kernel_file_open() doesn't steal a ref.

David

