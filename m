Return-Path: <linux-erofs+bounces-1477-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68FC6C9AB17
	for <lists+linux-erofs@lfdr.de>; Tue, 02 Dec 2025 09:32:25 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dLDXl1f3Tz3bps;
	Tue, 02 Dec 2025 19:32:23 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::331"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1764664343;
	cv=none; b=DJfrSA+MrFE1c8dvlHIP9xUcR7lTtQBz6eRK1Kq5eX5eGj2DAyJyj6sUiS6YciakRZI99Sw+fGhAsOMBKxAtw3CEBRhpwx1R01VvEfCX00G+/X4XO+OBrLV/jXyBc4x7QlX+g8GZrFv3wJyukf+zpxq/6528HZFh9r6MU4SMcgSJs7RiiVtNILnEADbs9s1UpNtgEtGUj1OR+dYIrGMENkPAbKwM0bTOA4TEPoDKkuZzSU94SnQRTycdKUe5JGV2no8WHmVLOcIJHUhl0RLElCm8jTyz6wazQbPFQXaw0YhKF3X4q0eKNoD9ELBeJOS9dhyxcG3gaYISV8Ak9b9+zw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1764664343; c=relaxed/relaxed;
	bh=Ln4SQHwhYsBYrbVK1d9qrFC8eAaQpDq2fkKdqTgFSAU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=H5pHNv1t2/OjlcPYZYAibSqCwAI/FzqFbL7LWmCQyWNjjm5bmGmdrEv4bmP9A6j9aISCcuKu8gGbrowKExPsqayhR6zVyMNeI4sSp01DMLJ+er1zuLLCJXsf2LUtyKFK+/Y719bTVYLZIaAT8eLjFD+39eiqbz7YMi2wm/8wOQ8QJu1q4VSpkljv8x9EF7CaRKsZBapRsWH5CnCTDjEQRalvH3LjhsFskqSjvHyI1AJ7PKdf+kyOZkXw/5+TUnGPejXEw7PyBZleoUZNtlQ9JYKPs5SODEIXDMnNWHElQ2+A7QClZOTbZPfx4sNQKWXgzFD6pVC1iAeF6dfTrPxJJQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org; dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Sh3OSNFV; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::331; helo=mail-wm1-x331.google.com; envelope-from=dan.carpenter@linaro.org; receiver=lists.ozlabs.org) smtp.mailfrom=linaro.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Sh3OSNFV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linaro.org (client-ip=2a00:1450:4864:20::331; helo=mail-wm1-x331.google.com; envelope-from=dan.carpenter@linaro.org; receiver=lists.ozlabs.org)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dLDXj6dhGz3bnL
	for <linux-erofs@lists.ozlabs.org>; Tue, 02 Dec 2025 19:32:20 +1100 (AEDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-47798ded6fcso29581005e9.1
        for <linux-erofs@lists.ozlabs.org>; Tue, 02 Dec 2025 00:32:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1764664337; x=1765269137; darn=lists.ozlabs.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ln4SQHwhYsBYrbVK1d9qrFC8eAaQpDq2fkKdqTgFSAU=;
        b=Sh3OSNFVLINdRFOFQ3xnKi8KwosRAHPvnlDBogLhSAv98CS35xe4cTTQmbnQqtFEkW
         6oXdmXXsAhGfb9PvVbrDn84S/Q8JiaXOLP67SB5Qh0taA1Q2cJs/LexO2BrjNqt3sUZD
         jh/QGb6RCB6Xo/PFA0E06gfuz+umoGzUGagVbIh8OeSF+lIOFuLh+yXAF4FCd6d0gE3f
         TTwL5+u/fNRyXuqW/ortL48ypmEe3FIgpZyJluiMHWf1cHN/QdvFueY1zZogU1jWXwIg
         qiETBmG+n+LYtsU4NIrW4bWoaCfTVABq+62L3aoGAoc894vT6epbM6IJ7d7IbrpCprNw
         Luyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764664337; x=1765269137;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ln4SQHwhYsBYrbVK1d9qrFC8eAaQpDq2fkKdqTgFSAU=;
        b=oeLjPxYrx9py+DBdQIm7uasbQJa9brrfds07SvCuhUG8N/uPH1GzIRN58qz4Sxn7n4
         rpzYrkdM7nYK1gB5YXs+pashf9q8QTn/c2DpyTbHJ6SsvBa3NI4i+iKntHZ4bhLdjo1h
         OBguesqQ8MRn85DUEEUnb79CvYhzY56A2AShdb6kKEQ4KbxAwZjFKpKjoCJMSZfmkUqC
         IoBTW6H9yOdVo4QiFDroJLMfb6DNPn/UyUihIQiaI7E9YUNhbzRiRUIMdcTRTH6rM4c/
         41s1ZI3NHRaBMcG+nQ+cJ2gnVzdkIn3BnhjeudQ91tTKrmiSBf+LjqZtiHUg7dCwy1+z
         p6+w==
X-Gm-Message-State: AOJu0Yzh7nguH2ilElQWQ9oAc5lt2NdHhIWedbj55peny/WIAiQKdb96
	8LZ2+sfEl3Ylhx7tjEeRCfInOeRhLtZKvmXq76J9LPSJOYFB0lc5AHFEw2Kmlwr1qqY=
X-Gm-Gg: ASbGncvMtZq2wwVd3cvhIwBkuRFqDbGTWvXM3We4yr5YfsT/zk9RdwhAmNwx/JyTBBw
	kv4ycBb263EpyNYIKhS5khXD6EnrOQOW+in2jy3/zHpm0pzrKegxB6vISNSvlWAEXTFqixk1BF9
	EDB3zB4H3cu1Cg/7LgD2bzXW0Dd8TFevaqIgbJAa1Iw8s5KWrd2yS8UuYJvnbgwpGATL/hmLhwS
	3YUgj8PCAlzTq0v2PZuDbSyffGuLAiiEn0CMewCrGJB3rDvDNnx6zxBjLs4rYf+A3RznMTKSz5j
	WKoYzA7D1fyu8JT2zaBzb3Usv4bCf8WlApGVCey/+O38QFcvtoCxzAgCf2dW/IT8DnaWbDjgQWo
	wdwebssYgd+UiMRtLfxsE78mTyD92deoRwGOygXBr7T4PlrLyzt8cXvgNEjZ5UlC+J56oUr2CGl
	vnBQZ6BS//QYI0iOJ+
X-Google-Smtp-Source: AGHT+IHL+YQ/NguglGy122lwsI3dMFlSyd3+NpkWe/1C+tJNY01g09ITz9MW5BMJ8KA2jnxlPYN4IA==
X-Received: by 2002:a05:600c:1c98:b0:46e:37fc:def0 with SMTP id 5b1f17b1804b1-477c10d4887mr379028855e9.9.1764664336513;
        Tue, 02 Dec 2025 00:32:16 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-47911143bb6sm314879985e9.3.2025.12.02.00.32.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Dec 2025 00:32:15 -0800 (PST)
Date: Tue, 2 Dec 2025 11:32:11 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Gao Xiang <xiang@kernel.org>
Cc: linux-erofs@lists.ozlabs.org
Subject: [bug report] erofs: enable error reporting for z_erofs_fixup_insize()
Message-ID: <aS6kC82aalX854i8@stanley.mountain>
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hello Gao Xiang,

Commit 30e13e41a0eb ("erofs: enable error reporting for
z_erofs_fixup_insize()") from Nov 27, 2025 (linux-next), leads to the
following Smatch static checker warning:

fs/erofs/decompressor.c:217 z_erofs_lz4_decompress_mem() warn: 'reason' isn't an ERR_PTR
fs/erofs/decompressor_lzma.c:193 z_erofs_lzma_decompress() warn: 'reason' is an error pointer or valid
fs/erofs/decompressor_zstd.c:180 z_erofs_zstd_decompress() warn: 'reason' is an error pointer or valid

fs/erofs/decompressor.c
    198 static int z_erofs_lz4_decompress_mem(struct z_erofs_decompress_req *rq, u8 *dst)
    199 {
    200         bool support_0padding = false, may_inplace = false;
    201         unsigned int inputmargin;
    202         u8 *out, *headpage, *src;
    203         const char *reason;
    204         int ret, maptype;
    205 
    206         DBG_BUGON(*rq->in == NULL);
    207         headpage = kmap_local_page(*rq->in);
    208 
    209         /* LZ4 decompression inplace is only safe if zero_padding is enabled */
    210         if (erofs_sb_has_zero_padding(EROFS_SB(rq->sb))) {
    211                 support_0padding = true;
    212                 reason = z_erofs_fixup_insize(rq, headpage + rq->pageofs_in,
    213                                 min_t(unsigned int, rq->inputsize,
    214                                       rq->sb->s_blocksize - rq->pageofs_in));
    215                 if (reason) {
    216                         kunmap_local(headpage);
--> 217                         return IS_ERR(reason) ? PTR_ERR(reason) : -EFSCORRUPTED;
    218                 }

The z_erofs_fixup_insize() function used to return error pointers, but
now it returns an error string or NULL.  So probably we could just
change this to:

		return -EFSCORRUPTED;

Are we planning to make it return error pointers again?

NULL means success in this case, right?  It's sort of weird how NULL means
success and a valid pointer means failure.

    219                 may_inplace = !((rq->pageofs_in + rq->inputsize) &
    220                                 (rq->sb->s_blocksize - 1));
    221         }

regards,
dan carpenter

