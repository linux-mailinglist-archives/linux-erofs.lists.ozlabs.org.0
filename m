Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0630967C2F
	for <lists+linux-erofs@lfdr.de>; Sun,  1 Sep 2024 22:48:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1725223690;
	bh=7342bL6XlId672ZUmqVGLoIQV+uvAdMIHD0PWaxvgpM=;
	h=References:In-Reply-To:Date:Subject:To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=H+EWF9v2ylcly0LtyPuAr9bcyuoo50APQ4gYzVs8qS9s8Roc7XbQTdXH1GBYEH2zJ
	 UU625RJ0irzUQ3/w9LS2HN7O50rf4MIHW3TL/vgsoJ2c4T4h9wmEsfb0aSICOgyLVQ
	 /YVs3oaOJM3d7VcNobx5dYohfEw1YRgsCfGzMBdMjyxBW4L0jazpElMxaoEtUjfo1t
	 K9KUioUTwekciZTgomghNEpQFM9aTp92+t1WSfQ+knpYGTd8UQqHm6T0QiGAxp2cyx
	 Q7t4AXEyQ1gXppCF6gODy7KlCeF7uelUI/wV0Zp7b89tVcaGO/VbgtnoXYTSbgBsss
	 Wgg+KoNMzhOUg==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WxkVf5kr1z2y66
	for <lists+linux-erofs@lfdr.de>; Mon,  2 Sep 2024 06:48:10 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::630"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1725223688;
	cv=none; b=fA4TGFw5ifK8verOFAG/8e/Qs6cXPgJkSC9rjpXcjHc2iVw4ttTGgxenXmpVMmytfvO0n1Umx2kpDi51FLuB6OQv/+FUk08OErdtQQGNwDgYh9mAMyoGkZm7NX9EWAXNHpfI0eC5d65Wm4lvEquTlfaZiWLvn6FWVW5TLF6uifP0qYCKMVvGdqVngFjKTqp8DTVrELlvfetvtlKbb8sm3jRkWSj2ew/AOgHMctVy0QvjKKK0FTnGt0YzlyZKUC5/FP5YKoig81THoJjtlHu3kWMUXBv9so/+SQ8X7EVEz/l/F5UpVA0h3/ME29jgSPIhvubn9Izbd594LzAvNzN9NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1725223688; c=relaxed/relaxed;
	bh=7342bL6XlId672ZUmqVGLoIQV+uvAdMIHD0PWaxvgpM=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type; b=ZoPYHMq2GpB+EsIowkrBC/vIapCKvyH8M7CMzt72x7zpeP2XLvzhDm5+LuvbZTfUxzoq6/Z5PEfrbsP0N+tIS/FM3Go9AioBQ8f3IFKHNtSzkidvc4HsV/HBW3uOrcbIOQGcCYR8PS1T+7VVXDQSjI7mHjiXRyBx8VH/PLUWPqRY95nUDluy6BROC3cEWfK1XdVC0Mu+/PFEEKqEwzxQ1hOyrx/6cDFQVFdW75UtS3nudAbprRFs+cFAXA59OZoEGZEprvv87AzTLQzrByelqVEVziAgfVVYgM5y4NWvR9zVEvhmcmjCiuEuNR3hVUR5vvcn0R/V1RQkfEEToC8wkg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=mZJSORs0; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::630; helo=mail-pl1-x630.google.com; envelope-from=dhavale@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=mZJSORs0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2607:f8b0:4864:20::630; helo=mail-pl1-x630.google.com; envelope-from=dhavale@google.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WxkVc2C7hz2xsG
	for <linux-erofs@lists.ozlabs.org>; Mon,  2 Sep 2024 06:48:08 +1000 (AEST)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-2021c08b95cso33527745ad.0
        for <linux-erofs@lists.ozlabs.org>; Sun, 01 Sep 2024 13:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725223685; x=1725828485; darn=lists.ozlabs.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7342bL6XlId672ZUmqVGLoIQV+uvAdMIHD0PWaxvgpM=;
        b=mZJSORs0Onhqkd4z3eRbPHsezjVuP269tPCBRk6as5cGiE6Ewfms8Adrd5nXNV22eY
         AAIiNoXMe3GgP03cFrSfV7nkrIGXGaGQJN/31pq8B1mTZ96BpqpfXljImjNeZXplvf4i
         WZjm42MZAXseMBrH6JN5KfO1L3IaQxRUhOih52dWWRoISMJmLCm2uB1RH+bK0kOCjt/e
         IR0fLvusMf+TChPCV8vu2lqMyqFQcWoJgiCfN36Ezxaajwu4H5EdU/rgOhqrxIhXJ8yW
         cwedOe3Rr/DyDd+ERfn8uf1Q8l/bUGmdmB5TzYDhBDR9MUlOwIrvCF9f2UlDnX/C5l6r
         uJ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725223685; x=1725828485;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7342bL6XlId672ZUmqVGLoIQV+uvAdMIHD0PWaxvgpM=;
        b=wdmXJBhs+BtJrINrF9XR9NKfyV5WGDdpDUVeNqXr63bQIcLdbGO4zYIxLNpzQgzu+5
         38YQLbZotqdQJZunB2CEYQXcc3ddWkE2FfBubEOoAI+bf0RIKN3I9nWgXLtGJhbnxVc1
         S6JSnM0kq7zoTAmKZcUQ+qhTdKZy3WBxbUU8yo515ijAkMA0Lhvx5LOx5lkWjxjpOVdU
         nKSPh66kHFGUSZS3PqLOnXJlU02btZZjNnDxkltlPPLM3PD46TBAg1JN5yMxYAUC5+xy
         fT3UKUbARX7GlmUZohvTScn07mGGyTQv3hkuPgJFVnGM3dzTsVm6Dh9OWiAhg/5jncuv
         inRA==
X-Gm-Message-State: AOJu0YwHu1cMy/KaU2G23vCJfksnovz7dfEKk+uJiKn08QkQSEGTRWPX
	93zrSr0zadFmYDQe3LhGV9C9HdoFUHmjA39LHxufxGaFKEpGvA5+/w/dcDHBJ53j0VAnfurWGQ4
	kk22wrD9np2AD8Q1kVbR5Do/RbUV5VfWeuQ5r
X-Google-Smtp-Source: AGHT+IEMvJPOrU7RuKGMf13ks25GLsZTvMpPVT1qgtrdF37+cbXAy+ic8ehvB5MsGIJjQhIvH/Wnnp5C63ZnslrlL4Y=
X-Received: by 2002:a17:902:ea02:b0:205:59b7:69c2 with SMTP id
 d9443c01a7336-20559b76c79mr66954165ad.7.1725223685206; Sun, 01 Sep 2024
 13:48:05 -0700 (PDT)
MIME-Version: 1.0
References: <20240830032840.3783206-1-hsiangkao@linux.alibaba.com> <20240830032840.3783206-3-hsiangkao@linux.alibaba.com>
In-Reply-To: <20240830032840.3783206-3-hsiangkao@linux.alibaba.com>
Date: Sun, 1 Sep 2024 13:47:53 -0700
Message-ID: <CAB=BE-R5p+R4dOwvENJARtYFdiT2UaTgtxtxgp5GJd5nUNE5rQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] erofs: support compressed inodes for fileio
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
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
From: Sandeep Dhavale via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Sandeep Dhavale <dhavale@google.com>
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Reviewed-by: Sandeep Dhavale <dhavale@google.com>

Thanks,
Sandeep.
