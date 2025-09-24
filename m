Return-Path: <linux-erofs+bounces-1091-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AF54B9B64F
	for <lists+linux-erofs@lfdr.de>; Wed, 24 Sep 2025 20:19:18 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cX4qm0Lc6z2yqg;
	Thu, 25 Sep 2025 04:19:16 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1758737955;
	cv=none; b=JUK1PhHsnw6NJVGeTwU2E5mWV+MxHzLB/HNCU04A3e/aPccJWTVOwYAImG0sYp0upNJBziYkbSSv1Jv53wdEwzVlaRqy80cvD8tCMNtXOA0GvZtewsQP12ygaMsSUMlpQPiCpEwLK/aRmQEs24HhJkfTDLAmgVpbvE8fPj0j8wdHJAok7WuCxfCM0tJPv+OHlWOj7MNBrxWL3ft6lMwDSmE6zfYxvLyVD1hH9z2etCNcusXD6rwOnKmr7G/jGlDnj+V4tE3em7iU+qmAej2JiHKm6xeUlm8Eufj9jnVaVJxiceqnZFpmdc9J2J2bGF2vAeQdW2rXXiBQK+/KytxQ1g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1758737955; c=relaxed/relaxed;
	bh=+GVKNWNi5HMo/lBrmWhAcg83rtAIgDpsQXqdRYrctmM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fVHfMe89Iz2YcP4cyl81uHOg0ExS2DPoPYFVJMeVeXh6d/bbnBuGRc+keqdYUYRMghWEqHID0MFRU+sT4eAd+7DyYDxnfLrY4qL02eg2yvm3kCy54OjAY76CoxGHpgc9ws7v2jyXd9bfdLdo8SiCCXJy8aRxvVCeS8vHPb6URwRqGo50ZpQmAvr7mLLGgI3NkbFOsBRbiFp2DdX5gzbA+bJaUdepKe6BYjTEUW56pX0HNhnhGpUTE36mUN5kkcYxVt8wpQmcQ4HcephaeF14lWJSELxbxCkb5piF/Qacw1eGJFumuFx+Wq2xD+DhWbwYMbZ/zyLh69Gh8wN4lxyvHw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZXfW0sDe; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZXfW0sDe; dkim-atps=neutral; spf=pass (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=david@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZXfW0sDe;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZXfW0sDe;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=david@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cX4ql0B5dz2xck
	for <linux-erofs@lists.ozlabs.org>; Thu, 25 Sep 2025 04:19:13 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758737949;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=+GVKNWNi5HMo/lBrmWhAcg83rtAIgDpsQXqdRYrctmM=;
	b=ZXfW0sDeZ1TMr/+gJtYJjgM/9BXoFDStAVj5k1xn1ciQSMP9AhuGe6C8lQBRb66XTuXY7N
	oVwTLjGG0Fuaj3jh3iKWfgHPR7xp2yQ8dM4DYxeU/9mmYc9CIMk/OLhhWnJJiFIowVL1Py
	Wh1H8qNWObowmkREFLRoADxAaIDBx4s=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758737949;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=+GVKNWNi5HMo/lBrmWhAcg83rtAIgDpsQXqdRYrctmM=;
	b=ZXfW0sDeZ1TMr/+gJtYJjgM/9BXoFDStAVj5k1xn1ciQSMP9AhuGe6C8lQBRb66XTuXY7N
	oVwTLjGG0Fuaj3jh3iKWfgHPR7xp2yQ8dM4DYxeU/9mmYc9CIMk/OLhhWnJJiFIowVL1Py
	Wh1H8qNWObowmkREFLRoADxAaIDBx4s=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-145-8VUmPuPuPvKUYkioAahElA-1; Wed, 24 Sep 2025 14:19:07 -0400
X-MC-Unique: 8VUmPuPuPvKUYkioAahElA-1
X-Mimecast-MFC-AGG-ID: 8VUmPuPuPvKUYkioAahElA_1758737947
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-46c84b3b27bso486925e9.2
        for <linux-erofs@lists.ozlabs.org>; Wed, 24 Sep 2025 11:19:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758737946; x=1759342746;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+GVKNWNi5HMo/lBrmWhAcg83rtAIgDpsQXqdRYrctmM=;
        b=JmfI+nntTzrDNRhNGDaoW47HEFBs+0wbnXftMva2elmH8hdek8AdXRY2ZMZRD6Ky99
         QVpwp3mPfVDKytgnnlDOefbsBVFqvK7/yIVAcuRBZ+qfNIDE7+yPGa2iUG3gzKTp+jzb
         ZlHMTNsbXvMUtvRqITPYrjs9UAZLHHCqUrTpSlaYiv42g5wEEIwlJiMWYPKJFjYHdQrP
         F2XJZ6r7dPgtS+OoyGMd9Jnc9nHFk1Vk2NktavBkv2DoY3X/vEoMpTq8HDdrLBj1QcqA
         +a05SaqbTsZZmhJBoLnkucFYV5cV43x0TYFl76GpZG4Yx55L1NA30BXykdcJwKpoUDaO
         wrGw==
X-Forwarded-Encrypted: i=1; AJvYcCUabGVRJ5zLWpz44ta0shdQe8MblhN5cah7dbaCO7562iueGiFopl2bodZm6DyK4xhiyrund71v16KUKQ==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwxROOdtu1eW2WEpoXFK+3XwbeL6ZH3bJTig60v6E867SSdK4p+
	gCUGZX0r9fEhVEa50SiiL60aTsCPwyqELs2i9gvHnkigmxDOcvH2UadOu2I8i6wUL1pnjWAIWAD
	UTabrztSb090vg5KaIU8JwfVUM2H7ICjMBWHnxw8jVK0KMH18nJjdReIyzG88RCcALA==
X-Gm-Gg: ASbGnct0uX65mw7Yd8dgvKKdvQUh0ofT4VMqjy7JVUV1KTaER1044nzxrvRhHXU/rNk
	mmJvlJmkSanbgGRsgwLj6lFLkl//DJabJbqGlYhdTLTsouwdUjntPAOqymx8r5rnhDnD8k1zl0D
	DehdQu0/n3YgVPSB4ye4SiEQbe88SRZ3C69NeOYNv/pb/5QQeofLBBQEgcDnD2ScFZzpQBAkKk4
	/slDzMMvWHREH7JzC6i2RWvezi5yUj3IV4t3A0QWclnaebRf7FMQJC1LXYPN4RQNrHXIcbLEOCo
	16ODdsdu/cJBfn48j0dBSSceudQ1wrnqy09QpQelt6WQVA/qQvCq7wpLD4Vz0CjN87osEo/f
X-Received: by 2002:a05:600c:1f16:b0:45f:2cf9:c229 with SMTP id 5b1f17b1804b1-46e3292ea63mr9349145e9.0.1758737946378;
        Wed, 24 Sep 2025 11:19:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHWiZOUG5fae31rurFMM73vXO6jc0v8mG1U6clMBR7MZT6xxje1XWRB74TlFYPhZbJta7VNSw==
X-Received: by 2002:a05:600c:1f16:b0:45f:2cf9:c229 with SMTP id 5b1f17b1804b1-46e3292ea63mr9348115e9.0.1758737945821;
        Wed, 24 Sep 2025 11:19:05 -0700 (PDT)
Received: from [192.168.3.141] (p57a1a5c4.dip0.t-ipconnect.de. [87.161.165.196])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e2a996da2sm50902695e9.5.2025.09.24.11.19.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Sep 2025 11:19:05 -0700 (PDT)
Message-ID: <1b01ebab-a43e-4344-ae38-50f0a031332f@redhat.com>
Date: Wed, 24 Sep 2025 20:19:00 +0200
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
Subject: Re: [PATCH kvm-next V11 0/7] Add NUMA mempolicy support for KVM
 guest-memfd
To: Shivank Garg <shivankg@amd.com>, willy@infradead.org,
 akpm@linux-foundation.org, pbonzini@redhat.com, shuah@kernel.org,
 seanjc@google.com, vbabka@suse.cz
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, dsterba@suse.com,
 xiang@kernel.org, chao@kernel.org, jaegeuk@kernel.org, clm@fb.com,
 josef@toxicpanda.com, kent.overstreet@linux.dev, zbestahu@gmail.com,
 jefflexu@linux.alibaba.com, dhavale@google.com, lihongbo22@huawei.com,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, rppt@kernel.org,
 surenb@google.com, mhocko@suse.com, ziy@nvidia.com, matthew.brost@intel.com,
 joshua.hahnjy@gmail.com, rakie.kim@sk.com, byungchul@sk.com,
 gourry@gourry.net, ying.huang@linux.alibaba.com, apopple@nvidia.com,
 tabba@google.com, ackerleytng@google.com, paul@paul-moore.com,
 jmorris@namei.org, serge@hallyn.com, pvorel@suse.cz, bfoster@redhat.com,
 vannapurve@google.com, chao.gao@intel.com, bharata@amd.com, nikunj@amd.com,
 michael.day@amd.com, shdhiman@amd.com, yan.y.zhao@intel.com,
 Neeraj.Upadhyay@amd.com, thomas.lendacky@amd.com, michael.roth@amd.com,
 aik@amd.com, jgg@nvidia.com, kalyazin@amazon.com, peterx@redhat.com,
 jack@suse.cz, hch@infradead.org, cgzones@googlemail.com,
 ira.weiny@intel.com, rientjes@google.com, roypat@amazon.co.uk,
 chao.p.peng@intel.com, amit@infradead.org, ddutile@redhat.com,
 dan.j.williams@intel.com, ashish.kalra@amd.com, gshan@redhat.com,
 jgowans@amazon.com, pankaj.gupta@amd.com, papaluri@amd.com,
 yuzhao@google.com, suzuki.poulose@arm.com, quic_eberman@quicinc.com,
 linux-bcachefs@vger.kernel.org, linux-btrfs@vger.kernel.org,
 linux-erofs@lists.ozlabs.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
 kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-coco@lists.linux.dev
References: <20250827175247.83322-2-shivankg@amd.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250827175247.83322-2-shivankg@amd.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: k0sE5YJxOTkF9aQ2u86AswH7_T2gES-GWFEDcX1GRnY_1758737947
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

On 27.08.25 19:52, Shivank Garg wrote:
> This series introduces NUMA-aware memory placement support for KVM guests
> with guest_memfd memory backends. It builds upon Fuad Tabba's work (V17)
> that enabled host-mapping for guest_memfd memory [1] and can be applied
> directly applied on KVM tree [2] (branch kvm-next, base commit: a6ad5413,
> Merge branch 'guest-memfd-mmap' into HEAD)
> 

Heads-up: I'll queue this (incl. the replacement patch for #4 from the 
reply) and send it tomorrow as a PR against kvm/next to Paolo.

-- 
Cheers

David / dhildenb


