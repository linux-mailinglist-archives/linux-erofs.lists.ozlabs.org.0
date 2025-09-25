Return-Path: <linux-erofs+bounces-1105-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id B51AAB9FFB4
	for <lists+linux-erofs@lfdr.de>; Thu, 25 Sep 2025 16:26:49 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cXbd33GMRz2yrm;
	Fri, 26 Sep 2025 00:26:47 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1758810407;
	cv=none; b=DH7S/AyNCMdTrtfH0gpFb2ze+pVJxzzdvLFEpcA97JDW3hcmgrgxwXIau6FAjojaBZS1Wq18IGXL71Eokq857WBegN3pVNzTkDl1w3Jn6mz+VE+cu13+TaApkteVIdSfipeDHq1HiL4yPe4tD/LYoPfzDElAnfpIWC7kkWfjCBb1b85Jq9sxSeeIjelhNH/dE4J30GkLOlDUHVaEwnjRcgJTKqZDf5CFXw4bcAs7kjrhlo7AQKFvh5VsATGTXVrczjTfikTSXiCN3rqkUO4T18c97FK1qAcWoGP0LkQjFZV6l7vGbxwqhn/U1uMIkgwex9Wpa6DcScoVJrz6Y4kP9A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1758810407; c=relaxed/relaxed;
	bh=7NbQWxxCkkna6kPG5JPAnaAdZblXa8Jj1l6IA0HQVeA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SszYYJxmcjG+AbY1kZcebfpW/3ZnbqnsLqzld6NqW4ZOYGV3rOKg0KH4en8Zm6s63FqMY/WG+X4aIxOp2RzXclK2YqhNALvXYVdz/hKn/Hh8GYPwHjtIG6+t4oPRZoYgUMWdI3DjH9GL3qNVbFKcMC7/1opFyN9RwMDZLFkZXWvv7MY9mr5smQQ+n2B7Bi3c5/HZF3sM6BN1j5hzcSBTe4SJeN1+ccQj5LzYhlSnCG8kMOuBLKX8TNKz8vDN64q1TOvjmNpe+/oLVVJFYLr260Jw2yiOx4/sgCX8ZmQDtBjdfTG5p7KAOrZPaoxQp20xiFNRPVohhJE8tCsgpngcxA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=D87Zy7lp; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=D87Zy7lp; dkim-atps=neutral; spf=pass (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=david@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=D87Zy7lp;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=D87Zy7lp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=david@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cXbd22pFsz2yqP
	for <linux-erofs@lists.ozlabs.org>; Fri, 26 Sep 2025 00:26:44 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758810402;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=7NbQWxxCkkna6kPG5JPAnaAdZblXa8Jj1l6IA0HQVeA=;
	b=D87Zy7lp6gvMfwpOYPjWRyE27tIxmGNQ3Gqsr1cIjx+s24MHfsFGtmx3Lc4sUQ5FXP+z5y
	zpC4eSvwXvkArN5Sb6w6tdU5HZ7zKXQWT7l4JDA6dtljcPyemt5+koHxu8wtzePiikmmPv
	Fwsz3uDqjjtolwZrDQaRtQHjoPMD08M=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758810402;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=7NbQWxxCkkna6kPG5JPAnaAdZblXa8Jj1l6IA0HQVeA=;
	b=D87Zy7lp6gvMfwpOYPjWRyE27tIxmGNQ3Gqsr1cIjx+s24MHfsFGtmx3Lc4sUQ5FXP+z5y
	zpC4eSvwXvkArN5Sb6w6tdU5HZ7zKXQWT7l4JDA6dtljcPyemt5+koHxu8wtzePiikmmPv
	Fwsz3uDqjjtolwZrDQaRtQHjoPMD08M=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-118-MIWMrjQtOcqEHTDuloWNfA-1; Thu, 25 Sep 2025 10:26:39 -0400
X-MC-Unique: MIWMrjQtOcqEHTDuloWNfA-1
X-Mimecast-MFC-AGG-ID: MIWMrjQtOcqEHTDuloWNfA_1758810399
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-46e38bd6680so1424505e9.1
        for <linux-erofs@lists.ozlabs.org>; Thu, 25 Sep 2025 07:26:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758810398; x=1759415198;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7NbQWxxCkkna6kPG5JPAnaAdZblXa8Jj1l6IA0HQVeA=;
        b=OXdFWwsAiuB79nAPGy6gEB4888jQpTBhx2RLmu1oCBjbXUpZuMklgAhJjzL7eX9cTw
         H0gJQJ6jpiIRzQIK7L6xZdPRk/4Sdrj1KalQAxRmx3SXpKPheVqh+SU/SY7aoDbtZIYQ
         uC1uVGDZbakV2ni4ukx0980rIR+YRpzHx9gH3jARZFC3Apw+Vi3Iij5zT29btzTi0+g0
         hOKi0WW2vem7p8A7zvbrh6yPzxVF1WvvL3HTBJ7hUQAcikM+EJxgAwTSX5iBeCcfyLOL
         yZA5W+o+mqPumz3PWPZsuVV9mgTQbH9dU/3TTfnB/s1P3RoDpB6jucwl4hGdCJ0LV+Ca
         xEFg==
X-Forwarded-Encrypted: i=1; AJvYcCWQmGmFNGKZOFyzU5A6mGUC8We/rjmxlzfsUWt1VFDhi3YfPFfkO0Se7nGpVHtdq8fTV16YvPFVuhW5gg==@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yx+wo/OQRjPpuJf6CBMrvXpkWDLlLDtFy2UsasDrslsNApQXTCy
	11vQDS2r4RmxdsMOLcTs+GJnHsOO90A00OBZmVJAbpi0VvjL4pFJkvCcPVcMRaLJXSYeLG5EGOT
	FSrPlIaxmH3EexZyReHRV+PuAj4OePYhQvYGqVrDrJaLyGoSzl5qHBgfM9WV/Lz9MKg==
X-Gm-Gg: ASbGnctYlSgVGlBXBpQTo48p2z0680yktXyLnHT/E+X2fmPW+Ff0g0YcdbFIH8YWhQL
	qWagLNf/Bylm/Lu4VjFs5kTXqa8dE68ffJPGEn7jmMOlxE3l+uf95U/Ke0EwQBmK48gAPND0tLT
	AtCanSLs51FdKz6Q6UCAX6gtL3Z3yva97Tw/AybfSP8oDNTI8xEE+U61R8A1RjcmzH9aAfHp2S6
	qWN3AXnAbv65O7s8wrzv35sNind4MPSDv5BkPKkHR0opLGbuSSv1k8DghAmbPO52mwVPt+xQJL/
	1mcnt9D8g04jAbQ3m02JL6cyoF6s6wh3tyHNTwwIioqm5VQMQGtBGc7DsP7KArO097A5qinuWlx
	JbEaAyUL/JyyBUbKgBETXsrerlvFi6xeOY2IY3H5NFFogN6Mlk61PKsE9akvDXhzyEm5s
X-Received: by 2002:a05:600c:4e8b:b0:46e:37fc:def0 with SMTP id 5b1f17b1804b1-46e37fce148mr14763445e9.9.1758810398153;
        Thu, 25 Sep 2025 07:26:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHjZJ0WBMi2SLpg5brCAPP2ix/UVmUI6Mp8N0XKACsUKpJXXguXTVe5P/uAzXY2rpR891e88g==
X-Received: by 2002:a05:600c:4e8b:b0:46e:37fc:def0 with SMTP id 5b1f17b1804b1-46e37fce148mr14762275e9.9.1758810397527;
        Thu, 25 Sep 2025 07:26:37 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f3f:f800:c101:5c9f:3bc9:3d08? (p200300d82f3ff800c1015c9f3bc93d08.dip0.t-ipconnect.de. [2003:d8:2f3f:f800:c101:5c9f:3bc9:3d08])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e33bf6ecbsm39061825e9.22.2025.09.25.07.26.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Sep 2025 07:26:36 -0700 (PDT)
Message-ID: <3a82a197-495f-40c3-ae1b-500453e3d1ec@redhat.com>
Date: Thu, 25 Sep 2025 16:26:32 +0200
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
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH kvm-next V11 4/7] KVM: guest_memfd: Use guest mem inodes
 instead of anonymous inodes
To: Sean Christopherson <seanjc@google.com>
Cc: Shivank Garg <shivankg@amd.com>, Ackerley Tng <ackerleytng@google.com>,
 willy@infradead.org, akpm@linux-foundation.org, pbonzini@redhat.com,
 shuah@kernel.org, vbabka@suse.cz, brauner@kernel.org,
 viro@zeniv.linux.org.uk, dsterba@suse.com, xiang@kernel.org,
 chao@kernel.org, jaegeuk@kernel.org, clm@fb.com, josef@toxicpanda.com,
 kent.overstreet@linux.dev, zbestahu@gmail.com, jefflexu@linux.alibaba.com,
 dhavale@google.com, lihongbo22@huawei.com, lorenzo.stoakes@oracle.com,
 Liam.Howlett@oracle.com, rppt@kernel.org, surenb@google.com,
 mhocko@suse.com, ziy@nvidia.com, matthew.brost@intel.com,
 joshua.hahnjy@gmail.com, rakie.kim@sk.com, byungchul@sk.com,
 gourry@gourry.net, ying.huang@linux.alibaba.com, apopple@nvidia.com,
 tabba@google.com, paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
 pvorel@suse.cz, bfoster@redhat.com, vannapurve@google.com,
 chao.gao@intel.com, bharata@amd.com, nikunj@amd.com, michael.day@amd.com,
 shdhiman@amd.com, yan.y.zhao@intel.com, Neeraj.Upadhyay@amd.com,
 thomas.lendacky@amd.com, michael.roth@amd.com, aik@amd.com, jgg@nvidia.com,
 kalyazin@amazon.com, peterx@redhat.com, jack@suse.cz, hch@infradead.org,
 cgzones@googlemail.com, ira.weiny@intel.com, rientjes@google.com,
 roypat@amazon.co.uk, chao.p.peng@intel.com, amit@infradead.org,
 ddutile@redhat.com, dan.j.williams@intel.com, ashish.kalra@amd.com,
 gshan@redhat.com, jgowans@amazon.com, pankaj.gupta@amd.com,
 papaluri@amd.com, yuzhao@google.com, suzuki.poulose@arm.com,
 quic_eberman@quicinc.com, linux-bcachefs@vger.kernel.org,
 linux-btrfs@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-security-module@vger.kernel.org, kvm@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-coco@lists.linux.dev
References: <20250827175247.83322-2-shivankg@amd.com>
 <20250827175247.83322-7-shivankg@amd.com> <diqztt1sbd2v.fsf@google.com>
 <aNSt9QT8dmpDK1eE@google.com> <dc6eb85f-87b6-43a1-b1f7-4727c0b834cc@amd.com>
 <b67dd7cd-2c1c-4566-badf-32082d8cd952@redhat.com>
 <aNVFrZDAkHmgNNci@google.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <aNVFrZDAkHmgNNci@google.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: unuijDfuB0t0Q7xQUpzFpOzbuSNrO3W9RNGGff_PCNs_1758810399
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

On 25.09.25 15:41, Sean Christopherson wrote:
> On Thu, Sep 25, 2025, David Hildenbrand wrote:
>> On 25.09.25 13:44, Garg, Shivank wrote:
>>> On 9/25/2025 8:20 AM, Sean Christopherson wrote:
>>> I did functional testing and it works fine.
>>
>> I can queue this instead. I guess I can reuse the patch description and add
>> Sean as author + add his SOB (if he agrees).
> 
> Eh, Ackerley and Fuad did all the work.  If I had provided feedback earlier,
> this would have been handled in a new version.  If they are ok with the changes,
> I would prefer they remain co-authors.

Yeah, that's what I would have done.

> 
> Regarding timing, how much do people care about getting this into 6.18 in
> particular?

I think it will be beneficial if we start getting stuff upstream. But 
waiting a bit longer probably doesn't hurt.

> AFAICT, this hasn't gotten any coverage in -next, which makes me a
> little nervous.

Right.

If we agree, then Shivank can just respin a new version after the merge 
window.

-- 
Cheers

David / dhildenb


