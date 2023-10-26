Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E0F97D7B4B
	for <lists+linux-erofs@lfdr.de>; Thu, 26 Oct 2023 05:34:10 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=f++MN0VY;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4SGBH42L4vz3vsf
	for <lists+linux-erofs@lfdr.de>; Thu, 26 Oct 2023 14:34:08 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=f++MN0VY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42e; helo=mail-pf1-x42e.google.com; envelope-from=zbestahu@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4SGBD21DrWz3dKn
	for <linux-erofs@lists.ozlabs.org>; Thu, 26 Oct 2023 14:31:29 +1100 (AEDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-6b20a48522fso409841b3a.1
        for <linux-erofs@lists.ozlabs.org>; Wed, 25 Oct 2023 20:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698291085; x=1698895885; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pG/yiI8lmu5ttHIV4nGpRPyvwtSsNLtKzIlMaESEX5U=;
        b=f++MN0VYdeRA2fFI8Qg1cibVh/vGutXa3VAK9Vi7gqMrduVhPFfhlFBD1dXktWyFsI
         aM2H1t0amomuA1n16wpzeTKu3b2kk9kCNxK0Sh/7aLjkPMvPEXYuiaI2FaM70B5IDHAf
         qR9/Ej3vgcKeleD/hGm57b4UVVaxRmBLrq07Z0NXGitAPmxUrsv5ab62YkIEnoP6mgxx
         qYj2wa1HoOoX1auf9JuK5txmywMg4+YaBxdFfX5IJKjwfY1+pI82EsqhSmLOA6N6kojs
         S2JwALMpY23KOD3hcNuM98tMXYOFdh0vad6phBhAghNFf2h2RS4eDNj1Z1hOwRXHNOwu
         G5Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698291085; x=1698895885;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pG/yiI8lmu5ttHIV4nGpRPyvwtSsNLtKzIlMaESEX5U=;
        b=HCuBuoIXUw0XY9OLc+UqpIMa+hRwukrBcmlNZ9aKOZcgZBxlmG5MSabjHrVTeA7I73
         kXPI7NqQpjPGGv2hYIsXsIMPbN0fwx4A2OxvonzlNGbyhmeRmjJJQwGijHtrxSpnxBUU
         6OXfdZDJl6BYo7Gsb3x1kzmZzvo55B6bY+2ctr3py3UGNfTDviyKRmEI/H7Kt8Jqc8zi
         hYrIU0N5vj2wPAg8TWnnsJ2zqqBqkfu1cq0GkjPMjycp0ro+bz/0FvoR+9pRIgjGhiym
         fLoJcdv1ngLMVOdhlj6rNYDsEE0rqg29BmofwYUuVKRqVxkyDX0dH1h9BkSYYOVkQHea
         5Csg==
X-Gm-Message-State: AOJu0Yxmm4yzC/Xq2Ca7yQYljsUu5o17c6fTxCxBd1Laj566mh+fJTR2
	vzKOgCCV0nxLFKfl94Qn+i733NiAUzM=
X-Google-Smtp-Source: AGHT+IH07xI4RkBOZRAYoV+NutElQZaay70zLfrIOC9VM5ODzrbszTCv4XfDw4XRZvP+OMTX1QjdVQ==
X-Received: by 2002:a05:6a20:e115:b0:153:78c1:c40f with SMTP id kr21-20020a056a20e11500b0015378c1c40fmr9374574pzb.15.1698291085427;
        Wed, 25 Oct 2023 20:31:25 -0700 (PDT)
Received: from localhost ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id n14-20020a056a0007ce00b006c046a60580sm1385612pfu.21.2023.10.25.20.31.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 20:31:25 -0700 (PDT)
Date: Thu, 26 Oct 2023 11:31:11 +0800
From: Yue Hu <zbestahu@gmail.com>
To: Ferry Meng <mengferry@linux.alibaba.com>
Subject: Re: [PATCH 1/2] erofs: get rid of ROOT_NID()
Message-ID: <20231026113052.00004950.zbestahu@gmail.com>
In-Reply-To: <20231026021627.23284-1-mengferry@linux.alibaba.com>
References: <20231026021627.23284-1-mengferry@linux.alibaba.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Thu, 26 Oct 2023 10:16:26 +0800
Ferry Meng <mengferry@linux.alibaba.com> wrote:

> Let's open code this helper for simplicity.
> 
> Signed-off-by: Ferry Meng <mengferry@linux.alibaba.com>

Reviewed-by: Yue Hu <huyue2@coolpad.com>
