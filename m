Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EA076D17D3
	for <lists+linux-erofs@lfdr.de>; Fri, 31 Mar 2023 08:52:45 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PnrZg2s0kz3f7p
	for <lists+linux-erofs@lfdr.de>; Fri, 31 Mar 2023 17:52:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=mOLK2yZx;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102d; helo=mail-pj1-x102d.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=mOLK2yZx;
	dkim-atps=neutral
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PnrZc1dQCz3cMl
	for <linux-erofs@lists.ozlabs.org>; Fri, 31 Mar 2023 17:52:39 +1100 (AEDT)
Received: by mail-pj1-x102d.google.com with SMTP id fy10-20020a17090b020a00b0023b4bcf0727so22452042pjb.0
        for <linux-erofs@lists.ozlabs.org>; Thu, 30 Mar 2023 23:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680245557;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qbDWzZeJfLQK7RD7XE5y+qJ0xX1vHzacok5EfQJ98yI=;
        b=mOLK2yZxZK6G7HZe/KTvq8dTFjTcpCJjilfy/4qdnBMaFrQuNkTwLnh0PExWTMAdkh
         9D0WoEhAmf0BIrFqXT7WbNY9NNYVRDDcb7GmeesDwJqxmLVv85jK14Z/6DOQ32uzPUnI
         UAW2omAZgucdh3+3wvFBJ/vi++6LXQuzBOu+ZLuPKbu7VtnUybPnqOvOo+OcS8nTzF99
         wZshpImXAixj7S257lZpEq9htYT60BKkkT4woafOGq5MI52tSs/QqBl7CfEBqCNd46Qv
         nCQadqJqJ5lwNmM6QvFwWC9fAMLpjSPjJOIPxV6Zb2G9djXrIokhcdTw63MLX0ajTA6g
         sNOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680245557;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qbDWzZeJfLQK7RD7XE5y+qJ0xX1vHzacok5EfQJ98yI=;
        b=7mFkEw/hD8hGIcIaPovjoTtFa/TIlK/1xd4/gi0V46q7VkuWsn70DEEEPXhr5UiDaz
         sT4nNv9NVtjT2xWfQF/tXvmdTozCCf/Rx5hzCwK5NKWNDp3ZosDb9IaLyiwX7N1C9+v8
         aKxvQeWKl2tuFy/EZUZAKmOwveEjGdNRrsZ3nEd9KPa+7xLzZzTka+JyAYm0DgSx9YJf
         XdJrr4Kxp4rZtIG8319tW96JOUbGSQSo/DmT5SyCKkRChvgd2FMJL3JQ5WF6L8pXODvf
         HVS8GO9JHC9Vp/dYY2f6HQriVMSigbPQKKqghAS4+Xmqa8o2Btf93CKX666tusNbw+Lm
         b/KQ==
X-Gm-Message-State: AAQBX9cO5p+WwwHX4jOfqxtT4Acwd7Yo/qTEF1bW9nhhwzGKA4IiUbOK
	XkO8yLfUdTSMmtUTEImLR+A=
X-Google-Smtp-Source: AKy350aalS9c8kO1V87B28++Z7kKjFTJ38PPIKG6Lhd1Jw1yjzpnuUkqFRkreLkt9ViEdCocowjGbA==
X-Received: by 2002:a17:902:cad1:b0:19e:e39b:6d90 with SMTP id y17-20020a170902cad100b0019ee39b6d90mr21061326pld.25.1680245557250;
        Thu, 30 Mar 2023 23:52:37 -0700 (PDT)
Received: from localhost ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id bf12-20020a170902b90c00b001a1ed2fce9asm781989plb.235.2023.03.30.23.52.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 30 Mar 2023 23:52:37 -0700 (PDT)
Date: Fri, 31 Mar 2023 14:59:28 +0800
From: Yue Hu <zbestahu@gmail.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [PATCH v2] erofs: tidy up EROFS on-disk naming
Message-ID: <20230331145928.00002cc0.zbestahu@gmail.com>
In-Reply-To: <20230331063149.25611-1-hsiangkao@linux.alibaba.com>
References: <20230329054935.78763-1-hsiangkao@linux.alibaba.com>
	<20230331063149.25611-1-hsiangkao@linux.alibaba.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
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
Cc: huyue2@coolpad.com, linux-erofs@lists.ozlabs.org, LMKL <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Fri, 31 Mar 2023 14:31:49 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

>  - Get rid of all "vle" (variable-length extents) expressions
>    since they only expand overall name lengths unnecessarily;
>  - Rename COMPRESSION_LEGACY to COMPRESSED_FULL;
>  - Move on-disk directory definitions ahead of compression;
>  - Drop unused extended attribute definitions;
>  - Move inode ondisk union `i_u` out as `union erofs_inode_i_u`.
> 
> No actual logical change.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Yue Hu <huyue2@coolpad.com>
