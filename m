Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id B72D29984F1
	for <lists+linux-erofs@lfdr.de>; Thu, 10 Oct 2024 13:26:32 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XPSBZ38w9z3bkG
	for <lists+linux-erofs@lfdr.de>; Thu, 10 Oct 2024 22:26:30 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1728559588;
	cv=none; b=HL7lamNyeN9ggKEuPqNZwSVy4nd8kE6wabth+wBrIKnI4dEQCJt42MRF5r9oUHcVMwdP7pvb2ZczSQe2Ic5yMybV4GADy5O/EdbfW16LRclzcU+XMT/jAi4ImKLFQ+FGcx5y3yrEKzsMCZEB7dCWjYSa7IUvN+eLbwveqLjOzr2xvDZR/T8gXGQeVb8qllp7qLynVo6SxOcZ9UBfs0rzg8NYF/3gbehAohad7WBDxiJTdyYbf9cCWA7Bb69VAqOkZa+wLOefK3iddldlMrzWcTEIhLjgvQQbWJDXE08R1gF9doUjP4sCPcrBpD6/3r65Inx3obXkntjaW/gYzzmCOw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1728559588; c=relaxed/relaxed;
	bh=NJUmRu+1qjEf0r4E7oHDRAPSAR+s1Bygz5pulK3ypfw=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=lVNG2UOTUuppL6lOeULj/D4ob79s6N0MlpJCT785NUZaVAh33iZ/086zGPAulLv94C7a7vVFjHR9vUOimMVVy0gg7cL7q4knypV82zdtkZ1dSp4VvqXc1CuKeC7d+RpaXI8/XQpRxBSTM5U64DQV38c4eqKhzFKt0aUr4y+wPR1fDlFo2/h/KWLiICl27iyvRtRCswB45MoWvs4Kv9zQ6aEMroIrPOZWJ8nVSsPvDr/vt8gXXCdWtWs9pnGLXjitLXoQZ1oD1kz9Wwbs5BRgmA33FNe4ZJirXThiTZwf13Okf6qJYThig9sTwqU4KCc5kE82jOUAHLCtdymwLTH5Ug==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=eynY0CN3; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=eynY0CN3; dkim-atps=neutral; spf=pass (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=eynY0CN3;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=eynY0CN3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XPSBW2bV2z2xjv
	for <linux-erofs@lists.ozlabs.org>; Thu, 10 Oct 2024 22:26:27 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728559584;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NJUmRu+1qjEf0r4E7oHDRAPSAR+s1Bygz5pulK3ypfw=;
	b=eynY0CN3YwRvFKQLDCKS7SHm/JSN6Lha0b8smp3WJ9im5a0WC26X8DaSy27HSDE4TuRXlF
	jJeoW/NwWwi5zWhT7HCTOzz/b2n94X0fT9RLz+oQtBz5wCRe2iqTnwxg/paAbHmfo1ZFwX
	iAHj8d5FVKB/r3OD3NNMSrgvgXjfUGY=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728559584;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NJUmRu+1qjEf0r4E7oHDRAPSAR+s1Bygz5pulK3ypfw=;
	b=eynY0CN3YwRvFKQLDCKS7SHm/JSN6Lha0b8smp3WJ9im5a0WC26X8DaSy27HSDE4TuRXlF
	jJeoW/NwWwi5zWhT7HCTOzz/b2n94X0fT9RLz+oQtBz5wCRe2iqTnwxg/paAbHmfo1ZFwX
	iAHj8d5FVKB/r3OD3NNMSrgvgXjfUGY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-646-NFOnjL-PMtKPIBAhYDEK-w-1; Thu,
 10 Oct 2024 07:26:18 -0400
X-MC-Unique: NFOnjL-PMtKPIBAhYDEK-w-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DD0E419560A2;
	Thu, 10 Oct 2024 11:26:15 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.4])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B56781956086;
	Thu, 10 Oct 2024 11:26:07 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20240821024301.1058918-8-wozizhi@huawei.com>
References: <20240821024301.1058918-8-wozizhi@huawei.com> <20240821024301.1058918-1-wozizhi@huawei.com>
To: Zizhi Wo <wozizhi@huawei.com>
Subject: Re: [PATCH 7/8] cachefiles: Fix NULL pointer dereference in object->file
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <303976.1728559565.1@warthog.procyon.org.uk>
Date: Thu, 10 Oct 2024 12:26:05 +0100
Message-ID: <303977.1728559565@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
X-Spam-Status: No, score=-0.3 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
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
Cc: yangerkun@huawei.com, jlayton@kernel.org, linux-kernel@vger.kernel.org, dhowells@redhat.com, linux-fsdevel@vger.kernel.org, hsiangkao@linux.alibaba.com, netfs@lists.linux.dev, linux-erofs@lists.ozlabs.org, yukuai3@huawei.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Zizhi Wo <wozizhi@huawei.com> wrote:

> +	spin_lock(&object->lock);
>  	if (object->file) {
>  		fput(object->file);
>  		object->file = NULL;
>  	}
> +	spin_unlock(&object->lock);

I would suggest stashing the file pointer in a local var and then doing the
fput() outside of the locks.

David

