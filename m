Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F47C94817E
	for <lists+linux-erofs@lfdr.de>; Mon,  5 Aug 2024 20:22:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1722882128;
	bh=7342bL6XlId672ZUmqVGLoIQV+uvAdMIHD0PWaxvgpM=;
	h=References:In-Reply-To:Date:Subject:To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=TGhIqi590UEAlSQXP6g7TrVbQbNFCn4zNRH7ideif4MXWRalDTDA04ISeVkb9Y1Qp
	 lHh2a/2GJstz4LSRWCzvKQu0pAq0f4e5nEtS4DFOKoIrA74Av5xj58NrA8lHJomoRP
	 BoTdvAJsYKF2HXg6srQfda1GpRu75R+oAqOjup4UC0GcrzlZTaQwm6rlDOpDSCpwcG
	 gg387iT/C0sX89lg/NqjqYjKxsk++E42bLNsPSV0oV0+RPTyV4H7+1SQFH1XnsLDLE
	 tKyNAYByKe4ydTt23fs+QXUUydqHxXgKNsNY4PJXcL/iUyGGWMyxzGR+iKYAB/65Fc
	 wv8hDOUc++Xzg==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Wd4Xc1lQvz3cbW
	for <lists+linux-erofs@lfdr.de>; Tue,  6 Aug 2024 04:22:08 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=SFRN9a+I;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2a00:1450:4864:20::335; helo=mail-wm1-x335.google.com; envelope-from=dhavale@google.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Wd4XX02G4z3cBP
	for <linux-erofs@lists.ozlabs.org>; Tue,  6 Aug 2024 04:22:03 +1000 (AEST)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-42809d6e719so75556115e9.3
        for <linux-erofs@lists.ozlabs.org>; Mon, 05 Aug 2024 11:22:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722882115; x=1723486915;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7342bL6XlId672ZUmqVGLoIQV+uvAdMIHD0PWaxvgpM=;
        b=VNgsdUHXriZKHvAaATq9HFwEG04vW72wIFEs+C4fO+Rm7IBa96wmz+LbJLjf3vWYgq
         pcxQKsvdtdE6VuQvReb1YeaU+VsTIhGYha85bf06vpj9gOHdnJBCpBETsiMRwfw28WCQ
         dXRQ/4tnqayMABZZnqF50HMF3tP0SGzM/0Y9RkoIYjaKQQgjAh3G1cnr/5jRTeYy9sxE
         twH9pQwa0sAzV0p8ubpgXKdyCMwcKxnSjN9YRtYZ0Fv2l7+LXyRhTDaBbIbKV1Rpl5xS
         eeW5Ag+YKbZ21Ol0Z9aQ0Hm2gt+MmhykUONNfxWUXg6mo0vQ4bFfgr9fIRr7UP3RIlQL
         Nkuw==
X-Gm-Message-State: AOJu0YzwT1YkJhAFWZApqgXdR4lOCsnfxtVW5wLhE5KPK46Ct8fjgMP5
	OcoMrdbmqk7dA9camdp9Rcixyai9sGXid/8X21D43/tX3iSe/71SKvxzU+vdGUpz8Z52698w4bG
	Sk6HNQ7vyfz5np4sTvHfrVn2H6s9k/EeNQZ97IXuK5jjmwe1aWB4su+g=
X-Google-Smtp-Source: AGHT+IEi4R095QzrXRyMSUiD/CyzW5l4RKHDco4NiHoPHpsNObnhOaqat27LvSE977By2Rc9OGt0QV25H5y+AzgWuRU=
X-Received: by 2002:a05:6000:1e97:b0:368:74c0:6721 with SMTP id
 ffacd0b85a97d-36bbc14a6edmr8146539f8f.38.1722882114834; Mon, 05 Aug 2024
 11:21:54 -0700 (PDT)
MIME-Version: 1.0
References: <20240805022826.2581887-1-hongzhen@linux.alibaba.com>
In-Reply-To: <20240805022826.2581887-1-hongzhen@linux.alibaba.com>
Date: Mon, 5 Aug 2024 11:21:43 -0700
Message-ID: <CAB=BE-TtHqEdeqpkgnV7fBL_K8am=WedpPqSzbQFpumnYE8X0A@mail.gmail.com>
Subject: Re: [PATCH] erofs-utils: fix extra argument to erofs_err()
To: Hongzhen Luo <hongzhen@linux.alibaba.com>
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
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Reviewed-by: Sandeep Dhavale <dhavale@google.com>

Thanks,
Sandeep.
